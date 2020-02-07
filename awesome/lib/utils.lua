-- Imports
local gears = require("gears")

-- Code
local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

local function rrect (radius)
   return function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
      --gears.shape.octogon(cr, width, height, radius)
      --gears.shape.rounded_bar(cr, width, height)
   end
end

-- Exports
local exports = {
   rrect = rrect,
   read_file = read_file,
}

return exports

