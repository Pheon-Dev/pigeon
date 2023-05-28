local M = { options = {} }

local defaults = {
	os = "linux", -- windows, osx
	plugin_manager = "lazy", -- packer, paq, vim-plug
	updates = {
		pretext = "",
		posttext = "",
		icon = "",
	},
	time = {
		format = "%H:%M",
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
	battery = {
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
				percentage = { icon = " 󰏰" },
			},
		},
	},
	internet = {
		signal = {
			unit = "dBm", -- dBm, mb/s
		},
		ethernet = {
			icons = {
				connected = "󰇧 ",
				disconnected = "󰇧 ",
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
