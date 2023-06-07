local ram = require("pigeon.config").options.ram

local M = {}

M.total_ram = function()
  local cmd = "free -mh --si | awk  {'print $2'} | head -n 2 | tail -1"
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        vim.g.total_ram = output
      else
        vim.g.total_ram = ""
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)
  local result

  result = vim.g.total_ram

  return result
end

M.perc_ram = function()
  local result

  result = vim.g.used_ram * 100 / vim.g.total_ram

  return result
end

M.used_ram = function()
  local cmd = "free -mh --si | awk  {'print $3'} | head -n 2 | tail -1"
  local job_id = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        vim.g.used_ram = output
      else
        vim.g.used_ram = "0"
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ job_id }, 0)
  local result

  result = vim.g.used_ram

  return result
end

M.ram_icon = ram.icon

return M
