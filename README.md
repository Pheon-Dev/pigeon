# Pigeon

This plugin adds to the current statusline and winbar by providing modules such as 
wifi, battery, volume, date, time, cpu, ram, storage, temperatures etc

> This plugin is currently in it's experimental stages. Expect some breaking changes.

![](/pigeon.png)

***

## Installation
### Lazy

```lua
    { 
        "Pheon-Dev/pigeon",
        event = "",
        config = function()
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
        end
    }

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

## Commands

* `PigeonToggle`: Toggle the entire plugin by either killing the pigeon or respawning it

```lua
vim.keymap.set("n", "<leader>p", ":PigeonToggle<CR>", { silent = true })
```

## Modules

*   \[x] battery
    *   \[x] capacity icon
    *   \[x] charge percentage
    *   \[x] status i.e charging, discharging
    *   \[x] animated battery icon while charging
    *   \[ ] toggle
*   \[x] internet
    *   \[x] wifi connection
        *   \[x] wifi essid
    *   \[ ] ethernet connection
    *   \[x] internet connection speed
        *   \[x] bit rate
    *   \[ ] toggle
*   \[x] date and time
    *   \[x] current date
    *   \[x] current time
    *   \[x] current day
    *   \[ ] toggle
*   \[ ] cpu
    *   System processor usage
    *   \[ ] toggle
*   \[ ] ram
    *   System memory usage
    *   \[ ] toggle
*   \[ ] updates
    *   Neovim plugins updates
    *   \[ ] toggle
*   \[ ] music
    *   current music playing
    *   \[ ] toggle
*   \[ ] volume
    *   audio volume
    *   \[ ] toggle

## Configuration

```lua
require("pigeon").setup({
  enabled = true,
  os = "linux",             -- windows, osx
  plugin_manager = "lazy",  -- packer, paq, vim-plug
  callbacks = {
    killing_pigeon = nil,
    respawning_pigeon = nil,
  },
  updates = {
    enabled = true,
    pretext = "",
    posttext = "",
    icon = "󱌖 ",
  },
  datetime = {
    enabled = true,
    time = {
      format = "%H:%M",
      posttext = "hrs",
      icon = " ",
    },
    day = {
      format = "%A",
      icon = " ",
    },
    date = {
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
})
```

## Contributions
- PRs, Issues from contributors are welcome
