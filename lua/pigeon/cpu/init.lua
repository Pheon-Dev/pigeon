local cpu = require("pigeon.config").options.cpu
local percentage = require("pigeon.config").options.percentage

local M = {}

M.cpu_load = function()
  local cmd_last = "head -n1 /proc/stat"
  local cmd_now = "sleep 0.05 && head -n1 /proc/stat | awk '{print $2}'"
  local last_job_id = vim.fn.jobstart(cmd_last, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        local cpu_sum = 0
        for i = 2, #output do
          cpu_sum = cpu_sum + tonumber(output[i])
        end
        vim.g.last_cpu_read = cpu_sum
        vim.g.last_cpu_idle = tonumber(output[5])
      else
        vim.g.last_cpu_read = 0
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ last_job_id }, 0)

  local now_job_id = vim.fn.jobstart(cmd_now, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        local cpu_sum = 0
        for i = 2, #output do
          cpu_sum = cpu_sum + tonumber(output[i])
        end
        vim.g.now_cpu_read = cpu_sum
        vim.g.now_cpu_idle = tonumber(output[5])
      else
        vim.g.now_cpu_read = 0
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ now_job_id }, 0)

  vim.g.cpu_delta = vim.g.now_cpu_read - vim.g.last_cpu_read
  vim.g.cpu_idle = vim.g.now_cpu_idle - vim.g.last_cpu_idle
  vim.g.cpu_used = vim.g.now_cpu_delta - vim.g.cpu_idle

  local result = 100 * vim.g.cpu_used / vim.g.cpu_delta

  return result
end

M.cpu_icon = cpu.icon

-- require("pigeon.commands.cpu").cpu_commands()

return M
