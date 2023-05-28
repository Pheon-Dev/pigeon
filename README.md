# Pigeon

This is a plugin that shows different module status on the status line or winbar.

![](/image-thin.png)

***

## Installation

```lua
    { "Pheon-Dev/pigeon" }
```

```lua
    local pigeon = require("pigeon")

    -- battery
    local battery_capacity = require("pigeon.battery").battery_capacity()
    local battery_charge = require("pigeon.battery").battery_charge()

    -- internet
    local wifi_status = require("pigeon.internet").wifi_status()
    local signal_speed = require("pigeon.internet").signal_speed()

    -- date and time
    local current_date = require("pigeon.datetime").current_date()
    local current_day = require("pigeon.datetime").current_day()
    local current_time = require("pigeon.datetime").current_time()
```

## Usage

```lua
-- Example in lualine
    ...
    sections = {
      ...
      lualine_x = {
          {
            function()
              local date = require("pigeon.datetime").current_date()
              local time = require("pigeon.datetime").current_time()
              local day = require("pigeon.datetime").current_day()
              local result = current_time .. current_date .. current_day
              return result
            end,
          }
      },
      ...
    },
    ...
```

***

![](/image.png)

## Modules

*   \[x] battery
    *   power status for a laptop
*   \[x] internet
    *   \[x] wifi connection
    *   \[ ] ethernet connection
    *   \[x] internet connection speed
*   \[x] date
    *   Current date
*   \[x] time
    *   Current time
*   \[x] day
    *   Current day
*   \[ ] cpu
    *   System processor usage
*   \[ ] ram
    *   System memory usage
*   \[ ] updates
    *   Neovim plugins updates

## Configuration

```lua
require("pigeon").setup({
    os = "linux", -- windows, osx
    plugin_manager = "lazy", -- packer, paq, vim-plug
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
        show_percentage = true,
        view = {
            charge = {
                zeros = { icon = " " },
                tens = { icon = " " },
                twenties = { icon = " " },
                thirties = { icon = " " },
                forties = { icon = " " },
                fifties = { icon = " " },
                sixties = { icon = " " },
                seventies = { icon = " " },
                eighties = { icon = " " },
                nineties = { icon = " " },
                hundred = { icon = " " },
            },
            status = {
                charging = { icon = " 󱐋" },
                discharging = { icon = " 󱐌" },
                not_charging = { icon = " " },
                full = { icon = " " },
                unknown = { icon = " " },
                percentage = { icon = " 󰏰" },
            },
        },
    },
    internet = {
        signal = {
            unit = "dBm", -- dBm, Mbps, Kbps, Gbps, Tbps
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
})
```
