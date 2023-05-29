# Pigeon

This plugin adds to the current statusline and winbar by providing modules such as 
wifi, battery, volume, date, time, cpu, ram, storage, temperatures etc

> This plugin is currently in it's experimental stages. Expect some breaking changes.

![](/image-thin.png)

***

## Installation

```lua
    { "Pheon-Dev/pigeon" }
```

## Initialisation
> Check below for configuration

```lua
    local config = {
        enabled = true,
        os = "linux", -- windows, osx
        plugin_manager = "lazy", -- packer, paq, vim-plug
        callbacks = {
            killing_pigeon = nil,
            respawning_pigeon = nil,
        },
        ...
    }

    require("pigeon").setup(config)

```

## Available Modules

```lua
    -- battery
    require("pigeon.battery").battery_capacity()
    require("pigeon.battery").battery_charge()
    require("pigeon.battery").battery_status()

    -- internet
    require("pigeon.internet").wifi_status()
    require("pigeon.internet").wifi_essid()
    require("pigeon.internet").bit_rate()

    -- date and time
    require("pigeon.datetime").current_date()
    require("pigeon.datetime").current_day()
    require("pigeon.datetime").current_time()
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
    *   \[x] capacity icon
    *   \[x] charge percentage
    *   \[x] status i.e charging, discharging
*   \[x] internet
    *   \[x] wifi connection
    *   \[ ] ethernet connection
    *   \[x] internet connection speed
*   \[x] date and time
    *   \[x] current date
    *   \[x] current time
    *   \[x] current day
*   \[ ] cpu
    *   System processor usage
*   \[ ] ram
    *   System memory usage
*   \[ ] updates
    *   Neovim plugins updates
*   \[ ] music
    *   current music playing
*   \[ ] volume
    *   audio volume

## Configuration

```lua
require("pigeon").setup({
	enabled = true,
	os = "linux", -- windows, osx
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
                not_charging = { icon = " " },
                full = { icon = " ✔ " },
                unknown = { icon = " " },
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
})
```
