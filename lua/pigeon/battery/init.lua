local battery = require("pigeon.config").options.battery

local M = {}

local cap, stat

if vim.fn.executable("acpi") == 1 then
  cap = 'acpi -b | grep -Po "[0-9]+%" | awk -F "%" \'{ print $1 }\''
  stat = 'acpi -b | awk -F "," \'{ print $1 }\' | awk -F " " \'{ print $3 }\''
elseif vim.fn.executable("pmset") == 1 then
  cap = 'pmset -g batt | grep -Eo "\\d+%"'
else
  cap = "cat /sys/class/power_supply/BAT0/capacity"
  stat = "cat /sys/class/power_supply/BAT0/status"
end


function M.battery_capacity()
  -- local capacity = vim.fn.system(cap)
  -- capacity = capacity:gsub("\n", "")

  local status_job_id = vim.fn.jobstart(stat, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        vim.g.battery_status = output
      end

    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ status_job_id }, 0)

  local capacity_job_id = vim.fn.jobstart(cap, {
    on_stdout = function(_, data, _)
      local output = table.concat(data, "\n")

      if output and #output > 0 then
        output = output:gsub("%s+", "") -- Remove whitespace
        vim.g.battery_capacity = output
      end

    end,
    stdout_buffered = true,
  })

  vim.fn.jobwait({ capacity_job_id }, 0)

  -- local job_id = vim.fn.jobstart(cap, {
  --   on_stdout = function(_, data, _)
  --     local output = table.concat(data, "\n")
  --
  --     if output and #output > 0 then
  --       output = output:gsub("%s+", "") -- Remove whitespace
  --       vim.g.battery_capacity = output
  --     end
  --
  --   end,
  --   stdout_buffered = true,
  -- })
  --
  -- vim.fn.jobwait({ job_id }, 0)
  -- local status = vim.fn.system(stat)
  -- status = status:gsub("\n", "")

  local result = vim.g.battery_status
  local charge = tonumber(vim.g.battery_capacity)
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

  result = tostring(result)

  if result == "Charging" then
    return icons[os.date("%s") % #icons + 1]
  end
  result = ""

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

function M.battery_status()
  local status = vim.fn.system(stat)
  status = status:gsub("\n", "")

  local result = status
  result = tostring(result)
  local status_res = ""

  if result == "Charging" then
    status_res = battery.view.status.charging.icon
  end
  if result == "Not" then
    status_res = battery.view.status.not_charging.icon
  end
  if result == "Full" then
    status_res = battery.view.status.full.icon
  end
  if result == "Discharging" then
    local icons = {
      battery.view.status.charging.icon,
      battery.view.status.discharging.icon,
    }
    return icons[os.date("%s") % #icons + 1]
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
  local capacity = vim.fn.system(cap)
  capacity = capacity:gsub("\n", "")

  local result = capacity

  if battery.show_percentage then
    return result .. battery.view.status.percentage.icon
  end
  return result
end

require("pigeon.commands.battery").battery_commands()

return M
