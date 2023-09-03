local battery = require("pigeon.config").options.battery

local M = {}

local cap, stat

if vim.fn.executable("acpi") == 1 then
  cap = 'acpi -b | grep -Po "[0-9]+%" | awk -F "%" \'{ print $1 }\''
  stat = "acpi -b | awk -F \",\" '{ print $1 }' | awk -F \" \" '{ print $3 }'"
elseif vim.fn.executable("pmset") == 1 then
  cap = 'pmset -g batt | grep -Eo "\\d+%"'
  stat = ""
else
  cap = "cat /sys/class/power_supply/BAT0/capacity"
  stat = "cat /sys/class/power_supply/BAT0/status"
end

function M.battery_job()
  local status_job_id = vim.fn.jobstart(stat, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "")
        vim.g.battery_status = output
      end
    end,
    stdout_buffered = true,
  })

  local capacity_job_id = vim.fn.jobstart(cap, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "")
        vim.g.battery_capacity = output
      end
    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ status_job_id }, 0)
  vim.fn.jobwait({ capacity_job_id }, 0)
end

function M.battery()
  M.battery_job()
  local result, capacity
  if vim.g.battery_status ~= nil then result = tostring(vim.g.battery_status) else result = "Fetching" end
  if vim.g.battery_capacity ~= nil then capacity = tostring(vim.g.battery_capacity) .. " 󰏰" else capacity = "" end
  local icon = battery.view.charge

  local icons = {
    icon.zeros.icon,
    icon.tens.icon,
    icon.twenties.icon,
    icon.thirties.icon,
    icon.forties.icon,
    icon.fifties.icon,
    icon.sixties.icon,
    icon.seventies.icon,
    icon.eighties.icon,
    icon.nineties.icon,
    icon.hundred.icon,
  }

  local status_res = ""

  local charge_icons = {
    battery.view.status.charging.icon,
    battery.view.status.discharging.icon,
  }

  if result == "Charging" then
    status_res = icons[os.date("%s") % #icons + 1]
  elseif result == "Not" then
    status_res = battery.view.status.not_charging.icon
  elseif result == "Full" then
    status_res = battery.view.status.full.icon
  elseif result == "Fetching" then
    status_res = "..."
  elseif result == "Discharging" then
    return charge_icons[os.date("%s") % #charge_icons + 1] .. " " .. capacity
  end
  if result == "" then
    status_res = battery.view.status.unknown.icon
  end
  if battery.show_status_text then
    status_res = status_res .. result
  end

  return status_res .. "" .. capacity
end

require("pigeon.commands.battery").battery_commands()

return M
