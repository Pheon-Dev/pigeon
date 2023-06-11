local internet = require("pigeon.config").options.internet

local M = {}

M.wifi_status = function()
  local cmd = 'iwconfig 2>&1 | grep "ESSID:" | awk -F "ESSID:" \'{print $2}\' | tr -d \'"\''
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        if output == "off/any" then
          vim.g.wifi_status = "disconnected"
        else
          vim.g.wifi_status = "connected"
        end
      else
        vim.g.wifi_status = "unknown"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)
  local result

  if vim.g.wifi_status == "disconnected" then
    result = internet.wifi.icons.disconnected
  elseif vim.g.wifi_status == "connected" then
    result = internet.wifi.icons.connected
  elseif vim.g.wifi_status == "unknown" then
    result = ""
  end

  return result
end

M.wifi_essid = function()
  local cmd = 'iwconfig 2>&1 | grep "ESSID:" | awk -F "ESSID:" \'{print $2}\' | tr -d \'"\''
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        if output == "off/any" then
          vim.g.wifi_essid = ""
        else
          vim.g.wifi_essid = output
        end
      else
        vim.g.wifi_status = "unknown"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)

  return vim.g.wifi_essid
end

M.bit_rate = function()
  local unit = internet.signal.unit

  local cmd
  local mbps =
  'iwconfig 2>&1 | grep "Bit Rate=" | awk -F "Bit Rate=" \'{print $2}\' | awk -F " " \'{print $1}\' | tr -d \'"\''
  local dbm =
  'iwconfig 2>&1 | grep "Tx-Power=" | awk -F "Tx-Power=" \'{print $2}\' | awk -F " " \'{print $1}\' | tr -d \'"\''

  if unit == "mbps" then
    cmd = mbps
  else
    cmd = dbm
  end
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")
      output = output:gsub("%s+", "") -- Remove whitespace
      if output and #output > 0 then
        vim.g.bit_rate = output .. " " .. unit
      else
        vim.g.bit_rate = " …"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)

  return vim.g.bit_rate
end

require("pigeon.commands.internet").internet_commands()

return M
