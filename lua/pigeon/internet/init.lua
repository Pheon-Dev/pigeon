local internet = require("pigeon.config").options.internet

local M = {}

M.wifi_status = function()
	local cmd
	if vim.fn.has("win32") == 1 then
		cmd = "ping -n 1 8.8.8.8 >nul 2>&1 && echo connected || echo disconnected"
	else
		cmd = "ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo connected || echo disconnected"
	end

	local job_id = vim.fn.jobstart(cmd, {
		on_exit = function(_, code)
			if code == 0 then
				vim.g.wifi_state = "connected"
			else
				vim.g.wifi_state = "disconnected"
			end
		end,
	})
	vim.fn.jobwait({ job_id }, 0)

	local wifi_state = vim.g.wifi_state or "unknown"

	if wifi_state == "disconnected" then
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

local command = vim.api.nvim_create_user_command

command("PigeonToggleInternet", function()
	internet.enabled = not internet.enabled
end, {})

if internet.enabled then
	print("󱗆 pigeon internet is module enabled")
	return M
else
	print("󱗆 pigeon internet is module disabled")
end
