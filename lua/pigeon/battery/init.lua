local config = require("pigeon.config")

local M = {}

function M.capacity()
	local capacity = vim.fn.system("cat /sys/class/power_supply/BAT0/capacity")
	local charge = tonumber(capacity)
	local result = ""

	if charge >= 0 and charge < 10 then
		result = " "
	end

	if charge >= 10 and charge < 20 then
		result = " "
	end

	if charge >= 20 and charge < 30 then
		result = " "
	end

	if charge >= 30 and charge < 40 then
		result = " "
	end

	if charge >= 40 and charge < 50 then
		result = " "
	end

	if charge >= 40 and charge < 50 then
		result = " "
	end

	if charge >= 50 and charge < 60 then
		result = " "
	end

	if charge >= 60 and charge < 70 then
		result = " "
	end

	if charge >= 70 and charge < 80 then
		result = " "
	end

	if charge >= 80 and charge < 90 then
		result = " "
	end

	if charge >= 90 and charge < 100 then
		result = " "
	end

	if charge >= 100 then
		result = " "
	end

	if result == "" then
		result = " "
	end

	result = result:gsub("\n", "")

	return result
end

function M.charge()
	local result = vim.fn.system("cat /sys/class/power_supply/BAT0/capacity")
	result = result:gsub("\n", "")

	return result
end

return M
