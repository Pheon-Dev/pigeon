local volume = require("pigeon.config").options.volume

local M = {}

function M.volume_job()
  local cmd_right, cmd_left, mute
  if vim.fn.executable("amixer") == 1 then
    cmd_right = "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'"
    cmd_left = "amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }'"
    mute = "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }'"
  elseif vim.fn.executable("pulsemixer") == 1 then
    cmd_right = "pulsemixer --get-volume | awk -F ' ' '{ print $1 }'"
    cmd_left = "pulsemixer --get-volume | awk -F ' ' '{ print $2 }'"
    mute = "pulsemixer --get-mute"
  end

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

  local mute_job_id = vim.fn.jobstart(mute, {
    on_stdout = function(_, data, _)
      local output = data[1]

      if output and #output > 0 then
        output = string.gsub(output, "%%", "")
        vim.g.mute = output
      end
    end,
    stdout_buffered = true,
  })
  vim.fn.jobwait({ right_job_id }, 0)
  vim.fn.jobwait({ left_job_id }, 0)
  vim.fn.jobwait({ mute_job_id }, 0)
end

function M.select_icon(volume_level)
  local lvl = tonumber(volume_level)
  if lvl < 33 then
    return volume.icons.low
  elseif lvl >= 33 and lvl < 66 then
    return volume.icons.medium
  else
    return volume.icons.high
  end
end

function M.volume()
  M.volume_job()
  local result = ""
  if vim.g.volume_left then
    result = result .. M.select_icon(vim.g.volume_left) .. " "
    if volume.show_percentage then
      result = result .. vim.g.volume_left .. " 󰏰"
    end
  else
    result = result .. "..."
  end

  result = result .. "  "
  if vim.g.volume_right then
    result = result .. M.select_icon(vim.g.volume_right) .. " "
    if volume.show_percentage then
      result = result .. vim.g.volume_right .. " 󰏰"
    end
  else
    result = result .. "..."
  end
  local muted = vim.g.mute == "1" and true or false

  return muted and volume.icons.mute or result
end

require("pigeon.commands.volume").volume_commands()

return M
