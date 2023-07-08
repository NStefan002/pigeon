local ram = require("pigeon.config").options.ram
local percentage = require("pigeon.config").options.percentage

local M = {}

function M.ram()
  M.total_ram = function()
    local cmd = "free -mh --si | awk  {'print $2'} | head -n 2 | tail -1"
    local job_id = vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        local output = table.concat(data, "\n")

        if output and #output > 0 then
          output = output:gsub("%s+", "") -- Remove whitespace
          vim.g.total_ram = output
        else
          vim.g.total_ram = ""
        end
      end,
      stdout_buffered = true,
    })

    vim.fn.jobwait({ job_id }, 0)
    local result

    if vim.g.total_ram == nil then return "" end
    result = tostring(vim.g.total_ram)

    return result
  end

  M.perc_ram = function()
    local cmd = "free | awk '/Mem/{printf(\"%d\"), $3/$2*100}'"
    local job_id = vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        local output = table.concat(data, "\n")

        if output and #output > 0 then
          output = output:gsub("%s+", "") -- Remove whitespace
          vim.g.perc_ram = output
        else
          vim.g.perc_ram = "0"
        end
      end,
      stdout_buffered = true,
    })

    vim.fn.jobwait({ job_id }, 0)
    local result

    if vim.g.perc_ram == nil then return "" end
    result = tostring(vim.g.perc_ram)

    if ram.show_percentage then
      return "(" .. result .. " 󰏰)"
    end
    return ""
  end

  M.used_ram = function()
    local cmd = "free -mh --si | awk  {'print $3'} | head -n 2 | tail -1"
    local job_id = vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        local output = table.concat(data, "\n")

        if output and #output > 0 then
          output = output:gsub("%s+", "") -- Remove whitespace
          vim.g.used_ram = output
        else
          vim.g.used_ram = "0"
        end
      end,
      stdout_buffered = true,
    })

    vim.fn.jobwait({ job_id }, 0)
    local result

    if vim.g.used_ram == nil then return "" end
    result = tostring(vim.g.used_ram)

    return ram.icon .. " " .. result
  end

  local total_ram = M.total_ram()
  local used_ram = M.used_ram()
  local perc_ram = M.perc_ram()

  local result = used_ram .. "/" .. total_ram .. " "
  local perc_result = used_ram .. "/" .. total_ram .. " " .. perc_ram

  return percentage and perc_result or result
end

require("pigeon.commands.ram").ram_commands()

return M
