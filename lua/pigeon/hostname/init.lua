local hostname = require("pigeon.config").options.hostname

local M = {}

M.hostname = function()
	local cmd = 'echo "$USER@$(hostname)"'
	local job_id = vim.fn.jobstart(cmd, {
		on_stdout = function(_, data, _)
			local output = table.concat(data, "\n")

			if output and #output > 0 then
				output = output:gsub("%s+", "") -- Remove whitespace
				vim.g.hostname = output
			else
				vim.g.hostname = "not found"
			end
		end,
		stdout_buffered = true,
	})

	vim.fn.jobwait({ job_id }, 0)
	local result

	result = hostname.icon .. vim.g.hostname

	return result
end

return M
