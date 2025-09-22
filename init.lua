
-- Root module
-- Re-export everything from lua/fkthemes/init.lua
local fkthemes = require("fkthemes.init")

-- Optional setup wrapper
local M = {}

M.setup = function()
  fkthemes.setup()
end

-- Expose commands directly if needed
M.next = fkthemes.next
M.set = fkthemes.set
M.telescope_picker = fkthemes.telescope_picker

return M
