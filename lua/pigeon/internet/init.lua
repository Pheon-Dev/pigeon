local internet = require("pigeon.config").options.internet.wifi

local M = {}

function M.wifi()
  local cmd = 'iwconfig 2>&1 | grep "ESSID:" | awk -F "ESSID:" \'{print $2}\' | tr -d \'"\''
  local bit
  local mbps =
  'iwconfig 2>&1 | grep "Bit Rate=" | awk -F "Bit Rate=" \'{print $2}\' | awk -F " " \'{print $1}\' | tr -d \'"\''
  local dbm =
  'iwconfig 2>&1 | grep "Tx-Power=" | awk -F "Tx-Power=" \'{print $2}\' | awk -F " " \'{print $1}\' | tr -d \'"\''

  if internet.bit_rate.unit == "mbps" then
    bit = mbps
  else
    bit = dbm
  end
  local bit_job_id = vim.fn.jobstart(bit, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")
      output = output:gsub("%s+", "") -- Remove whitespace
      if output and #output > 0 then
        vim.g.bit_rate = output .. " " .. internet.bit_rate.unit
      else
        vim.g.bit_rate = " …"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ bit_job_id }, 0)

  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        if output == "off/any" then
          vim.g.essid = ""
        else
          vim.g.essid = output
        end
      else
        vim.g.essid = "unknown"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)
  local result, essid, bit_rate

  if vim.g.essid ~= nil then essid = tostring(vim.g.essid) else essid = "" end
  if vim.g.bit_rate ~= nil then bit_rate = tostring(vim.g.bit_rate) else bit_rate = "" end

  if essid == "" then
    result = internet.status.disconnected
  elseif essid == "unknown" then
    result = ""
  else
    result = internet.status.connected
  end


  result = internet.status.enabled and internet.essid.enabled and internet.bit_rate.enabled and
      result .. " " .. essid .. " " .. bit_rate or result .. " " .. essid or result
  return result
end

require("pigeon.commands.internet").internet_commands()

return M
