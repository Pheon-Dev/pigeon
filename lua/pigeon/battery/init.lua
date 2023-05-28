local config = require("pigeon.config")

local M = {}

function M.init()
	local capacity = vim.fn.system("cat /sys/class/power_supply/BAT0/capacity")
	local charge = tonumber(capacity)
	local result = ""

	if charge >= 0 and charge < 10 then
		result = " " .. capacity
	end

	if charge >= 10 and charge < 20 then
		result = " " .. capacity
	end

	if charge >= 20 and charge < 30 then
		result = " " .. capacity
	end

	if charge >= 30 and charge < 40 then
		result = " " .. capacity
	end

	if charge >= 40 and charge < 50 then
		result = " " .. capacity
	end

	if charge >= 40 and charge < 50 then
		result = " " .. capacity
	end

	if charge >= 50 and charge < 60 then
		result = " " .. capacity
	end

	if charge >= 60 and charge < 70 then
		result = " " .. capacity
	end

	if charge >= 70 and charge < 80 then
		result = " " .. capacity
	end

	if charge >= 80 and charge < 90 then
		result = " " .. capacity
	end

	if charge >= 90 and charge < 100 then
		result = " " .. capacity
	end

	if charge >= 100 then
		result = " " .. capacity
	end

	if result == "" then
		result = " " .. capacity
	end

	result = result:gsub("\n", "")

	return result
end

return M
