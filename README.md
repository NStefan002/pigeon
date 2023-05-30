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
                local enabled = require("pigeon.config").options.battery.enabled
                local battery = require("pigeon.battery")

                local capacity = battery.battery_capacity()
                local charge = battery.battery_charge()
                local status = battery.battery_status()

                if enabled then
                  return status .. capacity .. charge
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
})
```

## Contributions
- PRs, Issues from contributors are welcome
