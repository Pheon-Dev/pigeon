local internet = require("pigeon.config").options.internet

local M = {}

M.wifi_status = function()
  -- local result = vim.fn.system('ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "true" || echo "false"')
  local cmd
  if vim.fn.has("win32") == 1 then
    cmd = "ping -n 1 8.8.8.8 >nul 2>&1 && echo connected || echo disconnected"
  else
    cmd = "ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo connected || echo disconnected"
  end

  local handle = vim.loop.spawn(cmd, {
    stdio = { nil, true, true },
    detached = true
  }, vim.schedule_wrap(function(code, signal)
    if code == 0 then
      vim.g.wifi_status = 'connected'
    else
      vim.g.wifi_status = 'disconnected'
    end
  end))
  vim.loop.unref(handle)

  local wifi_status = vim.g.wifi_status or "unknown"
  -- result = result:gsub("\n", "")
  -- result = tostring(result)
  if wifi_status == "disconnected" then
    return internet.wifi.icons.disconnected
  else
    return internet.wifi.icons.connected
  end
end

M.wifi_essid = function()
  local result = vim.fn.systemlist('iwconfig 2>&1 | grep -o "ESSID:.*" | grep -o "[Aa0-Zz9.]*"')
  result = tostring(result[2])

  return result
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

return M
