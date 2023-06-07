local cpu = require("pigeon.config").options.cpu
local percentage = require("pigeon.config").options.percentage

local M = {}

M.cpu_load = function()
	local PREFIX = ""

	local function get_load()
		-- Get the first line with aggregate of all CPUs
		local stat_file = io.popen("cat /proc/stat")
		local cpu_last = {}
		for line in stat_file:lines() do
			cpu_last = line:split("%s+")
			break
		end
		stat_file:close()

		local cpu_last_sum = 0
		for i = 2, #cpu_last do
			cpu_last_sum = cpu_last_sum + tonumber(cpu_last[i])
		end

		os.execute("sleep 0.05")

		stat_file = io.popen("cat /proc/stat")
		local cpu_now = {}
		for line in stat_file:lines() do
			cpu_now = line:split("%s+")
			break
		end
		stat_file:close()

		local cpu_sum = 0
		for i = 2, #cpu_now do
			cpu_sum = cpu_sum + tonumber(cpu_now[i])
		end

		local cpu_delta = cpu_sum - cpu_last_sum
		local cpu_idle = tonumber(cpu_now[5]) - tonumber(cpu_last[5])
		local cpu_used = cpu_delta - cpu_idle
		local cpu_usage = 100 * cpu_used / cpu_delta

		-- Keep this as last for our next read
		cpu_last = cpu_now
		cpu_last_sum = cpu_sum

		if cpu_usage == 100 then
			print(PREFIX .. " " .. cpu_usage .. "%")
		elseif cpu_usage >= 10 then
			print(PREFIX .. "  " .. cpu_usage .. "%")
		elseif cpu_usage <= 9 then
			print(PREFIX .. "   " .. cpu_usage .. "%")
		end
	end
end

-- require("pigeon.commands.cpu").cpu_commands()

return M
