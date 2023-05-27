# Pigeon

This is a plugin that shows different module status on the status line or winbar.

![](/image-thin.png)

***

## Installation

```lua
    { "Pheon-Dev/pigeon" }
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
              local datetime = require("pigeon").datetime()
              local battery = require("pigeon").battery()
              local wifi = require("pigeon").wifi()
              local result = datetime .. battery .. wifi
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
    *   \[ ] internet connection speed
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
