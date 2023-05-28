local config = require("pigeon.config")

local M = {}

M.wifi_status = function()
	local result = vim.fn.system('ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "󰤪 " || echo "󰤫 "')
	result = result:gsub("\n", "")

	return result
end

M.signal_speed = function()
	local result = ""

	local function fetch_signal_speed()
		local signal = vim.fn.systemlist('iwconfig 2>&1 | grep -o "Bit Rate=.*" | grep -o "[0-9.]*"')
		if signal and #signal > 0 then
			local speed = math.floor(tonumber(signal[1]) / 1)
			result = speed .. " dBm"
		else
			result = "N/A"
		end
	end

	fetch_signal_speed()

	return result
end

return M
