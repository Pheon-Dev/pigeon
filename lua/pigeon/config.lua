local M = {}

---@class PigeonOptions
M.defaults = {
	updates = {
		enabled = true,
    pretext = "",
    posttext = "",
		icon = "",
	},
	time = {
		enabled = true,
		format = "%H:%M",
		icon = "",
	},
	day = {
		enabled = true,
		format = "%A",
		icon = "",
	},
	date = {
		enabled = true,
		format = "%Y-%m-%d",
		icon = "",
	},
	battery = {
		enabled = true,
		show_percentage = false,
		view = {
			charge = {
				zeros = { icon = "" },
				tens = { icon = "" },
				twenties = { icon = "" },
				thirties = { icon = "" },
				forties = { icon = "" },
				fifties = { icon = "" },
				sixties = { icon = "" },
				seventies = { icon = "" },
				eighties = { icon = "" },
				nineties = { icon = "" },
				hundred = { icon = "" },
			},
			status = {
				charging = { icon = "󱐋" },
				discharging = { icon = "󱐌" },
				not_charging = { icon = "" },
				full = { icon = "" },
				unknown = { icon = "" },
			},
		},
	},
	internet = {
		ethernet = {
			enabled = true,
			icons = {
				connected = "󰇧 ",
				disconnected = "󰇧 ",
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
		icon = "",
	},
	temperature = {
		enabled = true,
    show_percentage = false,
		icon = "",
	},
	storage = {
		enabled = true,
    show_percentage = false,
		icon = "",
	},
	ram = {
		enabled = true,
    show_percentage = false,
		icon = "",
	},
	cpu = {
		enabled = true,
    show_percentage = false,
		icon = "",
	},
}

---@type PigeonOptions
M.options = {}

M.setup = function(opts)
  M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})
  require("pigeon.modules").init()
end

return M
