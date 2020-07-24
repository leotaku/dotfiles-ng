-- Imports
local keys = require("lib.relief.keys")

-- Code
local function method2curry(method)
   return function (self, ...)
      self[method](self, ...)
   end
end

-- Exports
local exports = {
   keys = keys,
   method2curry = method2curry,
}

return exports
