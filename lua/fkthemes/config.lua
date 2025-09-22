
local M = {}

M.options = {
  transparent_background = false,
  themes = {
    "tokyonight",
    "catppuccin",
    "gruvbox",
    "rose-pine",
    "onedark",
  },
  default_theme = "tokyonight", -- New option for default theme
}

M.setup = function(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

M.current = 1
local state_file = vim.fn.stdpath("data") .. "/fkthemes_state"

function M.save_state()
  local f = io.open(state_file, "w")
  if f then
    f:write(M.current)
    f:close()
  end
end

function M.load_state()
  local f = io.open(state_file, "r")
  if f then
    local idx = tonumber(f:read("*all"))
    -- Find the index of the default theme if it exists in the configured themes
    local default_idx = 1
    for i, theme_name in ipairs(M.options.themes) do
      if theme_name == M.options.default_theme then
        default_idx = i
        break
      end
    end

    if idx and M.options.themes[idx] then
      M.current = idx
    else
      -- If no saved state or invalid, use the index of the default theme
      M.current = default_idx
    end
    f:close()
  end
end

return M
