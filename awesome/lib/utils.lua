-- Imports
local gears = require("gears")

-- Code
function rrect (radius)
   return function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, radius)
      --gears.shape.octogon(cr, width, height, radius)
      --gears.shape.rounded_bar(cr, width, height)
   end
end

-- Exports
return {
   rrect = rrect,
}

