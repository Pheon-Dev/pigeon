local M = { options = {} }

local defaults = {
  enabled = true,
  os = "linux",            -- windows, osx
  plugin_manager = "lazy", -- packer, paq, vim-plug
  callbacks = {
    killing_pigeon = nil,
    respawning_pigeon = nil,
  },
  updates = {
    pretext = "",
    posttext = "",
    icon = "󱌖",
  },
  datetime = {
    time = {
      format = "%H:%M",
      posttext = "hrs",
      icon = "",
    },
    day = {
      format = "%A",
      icon = "",
    },
    date = {
      format = "%Y-%m-%d",
      icon = "",
    },
  },
  battery = {
    enabled = nil,
    show_percentage = true,
    show_status_text = true,
    view = {
      charge = {
        zeros = { icon = "󰂎" },
        tens = { icon = "󰁺" },
        twenties = { icon = "󰁻" },
        thirties = { icon = "󰁼" },
        forties = { icon = "󰁽" },
        fifties = { icon = "󰁾" },
        sixties = { icon = "󰁿" },
        seventies = { icon = "󰂀" },
        eighties = { icon = "󰂁" },
        nineties = { icon = "󰂂" },
        hundred = { icon = "󰁹" },
      },
      status = {
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
    signal = {
      unit = "mbps", -- mbps | mb/s | Mb/s | MB/s | Mbps | MBps
    },
    ethernet = {
      icons = {
        connected = "󰞉 ",
        disconnected = "󰕑 ",
      },
    },
    wifi = {
      icons = {
        connected = "󰤪",
        disconnected = "󰤫",
      },
    },
  },
  volume = {
    show_percentage = false,
    icon = "󱄠",
  },
  temperature = {
    show_percentage = false,
    icon = "",
  },
  storage = {
    show_percentage = false,
    icon = "󱛟",
  },
  ram = {
    show_percentage = false,
    icon = "󰍛",
  },
  cpu = {
    show_percentage = false,
    icon = "󰻠",
  },
}

M.load = function(opts)
  M.options = vim.tbl_deep_extend("force", defaults, opts or {})
end

return M
