local battery = require("pigeon.config").options.battery

local M = {}

function M.battery_capacity()
	local capacity = vim.fn.system("cat /sys/class/power_supply/BAT0/capacity")
	local charge = tonumber(capacity)
	local icon = battery.view.charge
	local result = ""

	if charge >= 0 and charge < 10 then
		result = icon.zeros.icon
	end

	if charge >= 10 and charge < 20 then
		result = icon.tens.icon
	end

	if charge >= 20 and charge < 30 then
		result = icon.twenties.icon
	end

	if charge >= 30 and charge < 40 then
		result = icon.thirties.icon
	end

	if charge >= 40 and charge < 50 then
		result = icon.forties.icon
	end

	if charge >= 50 and charge < 60 then
		result = icon.fifties.icon
	end

	if charge >= 60 and charge < 70 then
		result = icon.sixties.icon
	end

	if charge >= 70 and charge < 80 then
		result = icon.seventies.icon
	end

	if charge >= 80 and charge < 90 then
		result = icon.eighties.icon
	end

	if charge >= 90 and charge < 100 then
		result = icon.nineties.icon
	end

	if charge >= 100 then
		result = icon.hundred.icon
	end

	if result == "" then
		result = battery.status.unknown.icon
	end

	result = result:gsub("\n", "")

	return result
end

function M.battery_charging()
	local anim = {
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
		" ",
	}
	return anim[os.date("%s") % #anim + 1]
end

function M.battery_status()
	local status = vim.fn.system("cat /sys/class/power_supply/BAT0/status")
	local result = status:gsub("\n", "")
	result = tostring(result)
	local status_res = ""

	if result == "Charging" then
		status_res = battery.view.status.charging.icon
	end
	if result == "Not charging" then
		status_res = battery.view.status.not_charging.icon
	end
	if result == "Full" then
		status_res = battery.view.status.full.icon
	end
	if result == "Discharging" then
		status_res = battery.view.status.discharging.icon
	end
	if result == "" then
		status_res = battery.view.status.unknown.icon
	end
	if battery.show_status_text then
		status_res = result .. status_res
	end
	return status_res
end

function M.battery_charge()
	local capacity = vim.fn.system("cat /sys/class/power_supply/BAT0/capacity")
	local result = capacity:gsub("\n", "")

	if battery.show_percentage then
		return result .. battery.view.status.percentage.icon
	end
	return result
end

return M
