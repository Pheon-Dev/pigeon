local M = { options = {} }

local defaults = {
  enabled = true,
  os = "linux",           -- windows, osx
  plugin_manager = "lazy", -- packer, paq, vim-plug
  updates = {
    enabled = true,
    pretext = "",
    posttext = "",
    icon = "󱌖 ",
  },
  hostname = {
    enabled = true,
    icon = " "
  },
  datetime = {
    enabled = true,
    time = {
      enabled = true,
      format = "%H:%M",
      posttext = "hrs",
      icon = " ",
    },
    day = {
      enabled = true,
      format = "%A",
      icon = " ",
    },
    date = {
      enabled = true,
      format = "%Y-%m-%d",
      icon = " ",
    },
  },
  battery = {
    enabled = true,
    show_percentage = true,
    show_status_text = false,
    view = {
      charge = {
        zeros = { icon = "󰂎 " },
        tens = { icon = "󰁺 " },
        twenties = { icon = "󰁻 " },
        thirties = { icon = "󰁼 " },
        forties = { icon = "󰁽 " },
        fifties = { icon = "󰁾 " },
        sixties = { icon = "󰁿 " },
        seventies = { icon = "󰂀 " },
        eighties = { icon = "󰂁 " },
        nineties = { icon = "󰂂 " },
        hundred = { icon = "󰁹 " },
      },
      status = {
        enabled = true,
        charging = { icon = " 󱐋" },
        discharging = { icon = " 󱐌" },
        not_charging = { icon = "  " },
        full = { icon = "  " },
        unknown = { icon = " " },
        critical = { icon = " " },
        percentage = { icon = " 󰏰" },
      },
    },
  },
  internet = {
    enabled = true,
    signal = {
      enabled = true,
      unit = "mbps", -- mbps | mb/s | Mb/s | MB/s | Mbps | MBps
    },
    ethernet = {
      enabled = true,
      icons = {
        connected = "󰞉 ",
        disconnected = "󰕑 ",
      },
    },
    wifi = {
      enabled = true,
      icons = {
        connected = "󰤪",
        disconnected = "󰤫",
      },
    },
  },
  volume = {
    enabled = true,
    show_percentage = false,
    icon = "󱄠",
  },
  temperature = {
    enabled = true,
    show_percentage = false,
    icon = "",
  },
  storage = {
    enabled = true,
    show_percentage = false,
    icon = "󱛟",
  },
  ram = {
    enabled = true,
    show_percentage = false,
    icon = "󰍛",
  },
  cpu = {
    enabled = true,
    show_percentage = false,
    icon = "󰻠",
  },
}

M.load = function(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
