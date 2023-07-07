![Linux](https://img.shields.io/badge/Linux-%23.svg?logo=linux&color=FCC624&logoColor=black)
![macOS](https://img.shields.io/badge/macOS-%23.svg?logo=apple&color=000000&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-%23.svg?logo=windows&color=0078D6&logoColor=white)

<h1 align="center">
 Pigeon
</h1>

<p align="center">
<img src="https://www.ibs.it/images/9781666394030_0_536_0_75.jpg" alt="cher-ami" />
</p>

<p align="center">
This plugin adds to the current statusline and winbar by providing modules such as 
wifi, battery, volume, date, time, cpu, ram, storage, temperatures etc
</p>


> This plugin is currently in it's experimental stages. Expect some breaking changes.
> Please feel free to use it and file any issues and PRs whenever the pigeon is not
> feeding correctly, doesn't home, gets lost, nests a lot and does nothing or [gets shot](https://en.wikipedia.org/wiki/Cher_Ami).
>
> Polite reminder:
> use the modules you only need, not all of them. Pigeons don't carry parcels.

<p align="center">
<img src="/pigeon.png" alt="online" />
<img src="/pigeon-offline.png" alt="offline" />
</p>

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
                -- more config options here
            }

            require("pigeon").setup(config)
        end
    }

```

## Available Modules

```lua
-- battery
require("pigeon.battery").battery()

-- internet
require("pigeon.internet").wifi()

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
                local enabled = require("pigeon.config").options.battery.enabled
                local battery = require("pigeon.battery").battery()

                if enabled then
                  return battery
                else
                  return ""
                end
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

### Battery Module
* `PigeonToggleBattery`: Toggle the battery modules and its submodules
* `PigeonToggleBatteryStatus`: Toggle the battery status submodule
* `PigeonToggleBatteryCapacity`: Toggle the battery capacity icon submodule
* `PigeonToggleBatteryCharge`: Toggle the battery charge and it's percentage submodule

### Internet Module
* `PigeonToggleInternet`: Toggle the internet module and its submodules
* `PigeonToggleEthernet`: Toggle the ethernet submodule
* `PigeonToggleWifi`: Toggle the wifi icon submodule
* `PigeonToggleBitRate`: Toggle the bitrate submodule
* `PigeonToggleEssid`: Toggle the ESSID submodule(wifi name)

### Date and Time Module
* `PigeonToggleDateTime`: Toggle the date and time modules and its submodules
* `PigeonToggleDate`: Toggle the date submodule
* `PigeonToggleTime`: Toggle the time submodule
* `PigeonToggleDay`: Toggle the day submodule

```lua
local map = vim.api.nvim_set_keymap
map("n", "<leader>pp", ":PigeonToggle<CR>", { silent = true, desc = "Toggle All Pigeon Modules" })
map("n", "<leader>pd", ":PigeonToggleDateTime<CR>", { silent = true, desc = "Toggle Date and Time Module" })
map("n", "<leader>pi", ":PigeonToggleInternet<CR>", { silent = true, desc = "Toggle Internet Module" })
map("n", "<leader>pb", ":PigeonToggleBattery<CR>", { silent = true, desc = "Toggle Battery Module" })
...
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
	os = "linux", -- windows, osx
	plugin_manager = "lazy", -- packer, paq, vim-plug
	updates = {
		enabled = true,
		pretext = "",
		posttext = "",
		icon = "󱌖 ",
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
      status = {
        connected = "󰤪",
        disconnected = "󰤫",
        enabled = true,
      },
      essid = {
        enabled = true,
      },
      bit_rate = {
        enabled = true,
        unit = "mbps", -- or dbm
      }
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
> no pigeons where harmed or killed in the making of this plugin
- PRs and Issues are always welcome.
