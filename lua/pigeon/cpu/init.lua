local cpu = require("pigeon.config").options.cpu
local percentage = require("pigeon.config").options.percentage

local M = {}

M.cpu_load = function()
	local cmd_last = "head -n1 /proc/stat | awk -F 'cpu' '{print $2}'"
	-- local cmd_now = "sleep 0.05 && head -n1 /proc/stat"
	local last_job_id = vim.fn.jobstart(cmd_last, {
		on_stdout = function(_, data, _)
			local output = table.concat(data, "\n")

			-- if output and #output > 0 then
			output = output:gsub("%s+", ",") -- Remove whitespace
			local cpu_last_table = {"0", output, "0"}
			local cpu_sum = 0
			-- for line in string.gmatch(output, "^[%s]+") do
			-- 	table.insert(cpu_last_table, tonumber(line))
			-- 	-- cpu_sum = cpu_sum + tonumber(line)
			-- end
			local function sum_table_values(tbl)
				local sum = 0
				for _, value in pairs(tbl) do
					sum = sum + value
				end
				return sum
			end

			-- Example usage
			local myTable = { 10, 20, 30, 40, 50 }
			local result = sum_table_values(cpu_last_table)
			print(result) -- Output: 150
		end,
		stdout_buffered = true,
	})

	vim.fn.jobwait({ last_job_id }, 0)
	-- print(vim.g.last_cpu_read)

	-- local now_job_id = vim.fn.jobstart(cmd_now, {
	--   on_stdout = function(_, data, _)
	--     local output = table.concat(data, "\n")
	--
	--     if output and #output > 0 then
	--       output = output:gsub("%s+", "") -- Remove whitespace
	--       local cpu_sum = 0
	--       for i = 2, #output do
	--         cpu_sum = cpu_sum + tonumber(output[i])
	--       end
	--       vim.g.now_cpu_read = cpu_sum
	--       vim.g.now_cpu_idle = tonumber(output[5])
	--     else
	--       vim.g.now_cpu_read = 0
	--     end
	--   end,
	--   stdout_buffered = true,
	-- })
	--
	-- vim.fn.jobwait({ now_job_id }, 0)
	--
	--       -- print("last cpu read: ", vim.g.last_cpu_read)
	--       -- print("last cpu idle: ", vim.g.last_cpu_idle)
	--
	-- local cpu_delta = vim.g.now_cpu_read - vim.g.last_cpu_read
	-- local cpu_idle = vim.g.now_cpu_idle - vim.g.last_cpu_idle
	-- local cpu_used = cpu_delta - cpu_idle
	--
	-- local result = 100 * cpu_used / cpu_delta

	local result = 0
	return result
end

M.cpu_icon = cpu.icon

-- require("pigeon.commands.cpu").cpu_commands()

return M
