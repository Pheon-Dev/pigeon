local internet = require("pigeon.config").options.internet

local M = {}

local cmd = 'iwconfig 2>&1 | grep "ESSID:" | awk -F "ESSID:" \'{print $2}\' | tr -d \'"\''

M.wifi_status = function()
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      -- local wifi_status
      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        if output == "off/any" then
          vim.g.wifi_status = "disconnected"
        else
          vim.g.wifi_status = "connected"
        end
        print("󱗆 pigeon wifi status: " .. vim.g.wifi_status)
      else
        vim.g.wifi_status = "unknown"
      end

      -- TODO: Do something with the wifi_status, such as updating the statusline
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
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      -- local wifi_status
      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        if output == "off/any" then
          vim.g.wifi_essid = "offline"
        else
          vim.g.wifi_essid = output
        end
        print("󱗆 pigeon connected to: " .. vim.g.wifi_status)
      else
        vim.g.wifi_status = "unknown"
      end

      -- TODO: Do something with the wifi_status, such as updating the statusline
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)

  -- local wifi_state = vim.fn.systemlist('iwconfig 2>&1 | grep -o "ESSID:.*" | grep -o "[Aa0-Zz9.]*"')
  -- wifi_state = tostring(wifi_state[2])
  return vim.g.wifi_essid
end

M.bit_rate = function()
  local result = ""
  local unit = internet.signal.unit

  local function fetch_signal_speed()
    local signal = vim.fn.systemlist('iwconfig 2>&1 | grep -o "Bit Rate=.*" | grep -o "[0-9.]*"')
    if signal and #signal > 0 then
      result = tonumber(signal[1]) .. " " .. unit
    else
      result = " 󰪎"
    end
  end

  fetch_signal_speed()

  return result
end

require("pigeon.commands.internet").internet_commands()

return M
