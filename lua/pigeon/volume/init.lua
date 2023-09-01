local volume = require("pigeon.config").options.volume

local M = {}

function M.volume_job()
	local cmd_right = "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'"
	local cmd_left = "amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'"

	local right_job_id = vim.fn.jobstart(cmd_right, {
		on_stdout = function(_, data, _)
			local output = data[1]

			if output and #output > 0 then
				output = string.gsub(output, "%%", "")
				vim.g.volume_right = output
			end
		end,
		stdout_buffered = true,
	})

	local left_job_id = vim.fn.jobstart(cmd_left, {
		on_stdout = function(_, data, _)
			local output = data[1]

			if output and #output > 0 then
				output = string.gsub(output, "%%", "")
				vim.g.volume_left = output
			end
		end,
		stdout_buffered = true,
	})

	vim.fn.jobwait({ right_job_id }, 0)
	vim.fn.jobwait({ left_job_id }, 0)
end

function M.volume()
	M.volume_job()
	local result = volume.icon .. " "
	if vim.g.volume_left then
		result = result .. vim.g.volume_left .. " 󰏰"
	else
		result = result .. "..."
	end

	result = result .. "  "
	if vim.g.volume_right then
		result = result .. vim.g.volume_right .. " 󰏰"
	else
		result = result .. "..."
	end

	return result
end

require("pigeon.commands.volume").volume_commands()

return M
