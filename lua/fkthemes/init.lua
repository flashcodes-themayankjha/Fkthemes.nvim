local config = require("fkthemes.config")
local M = {}

-- Helper: Apply transparency to UI components
local function apply_transparency()
  local highlights = {
    "Normal",
    "NormalFloat",
    "FloatBorder",
    "TelescopeNormal",
    "TelescopePromptNormal",
    "TelescopePreviewNormal",
    "TelescopeResultsNormal",
    "TelescopePromptBorder",
    "TelescopeResultsBorder",
    "TelescopePreviewBorder",
    "TelescopePromptTitle",
    "TelescopeResultsTitle",
    "TelescopePreviewTitle",
    "BufferLineFill",
    "Lualine",
    "LualineInactive",
    "WhichKey",
    "WhichKeyFloat",
    "LazyNormal",
    "LazyFloat",
    "CmpPmenu",
    "CmpPmenuSel",
    "Pmenu",
    "PmenuSel",
    "PmenuSbar",
    "PmenuThumb",
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl, { bg = "none" })
  end
end

-- Safely apply a theme
function M.apply(idx)
  local theme = config.options.themes[idx]
  if theme then
    if theme == "catppuccin" then
      require("catppuccin").setup({
        transparent_background = true,
      })
    end
    local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
    if ok then
      config.current = idx
      config.save_state()
      if config.options.transparent_background then
        apply_transparency()
      end
    else
      vim.notify("Fkthemes: colorscheme '"..theme.."' not installed!", vim.log.levels.WARN)
    end
  end
end

-- Cycle next theme
function M.next()
  local idx = config.current % #config.options.themes + 1
  M.apply(idx)
end

-- Set theme by name
function M.set(name)
  for i, theme in ipairs(config.options.themes) do
    if theme == name then
      M.apply(i)
      return
    end
  end
  vim.notify("Fkthemes: Theme '"..name.."' not found!", vim.log.levels.WARN)
end

-- Telescope picker with live preview
function M.telescope_picker()
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("Fkthemes: Telescope not installed!", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  if config.options.transparent_background then
    apply_transparency()
  end

  pickers.new({}, {
    prompt_title = "🎨 Fkthemes",
    finder = finders.new_table { results = config.options.themes },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function preview_current()
        local entry = action_state.get_selected_entry()
        if entry then
          M.set(entry[1])
        end
      end

      -- override movement keys to preview theme while navigating
      for _, key in ipairs({ "<Down>", "<Up>", "j", "k" }) do
        map("i", key, function()
          if key == "<Down>" or key == "j" then
            actions.move_selection_next(prompt_bufnr)
          else
            actions.move_selection_previous(prompt_bufnr)
          end
          preview_current()
        end)
        map("n", key, function()
          if key == "<Down>" or key == "j" then
            actions.move_selection_next(prompt_bufnr)
          else
            actions.move_selection_previous(prompt_bufnr)
          end
          preview_current()
        end)
      end

      -- Enter to finalize
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          M.set(selection[1])
        end
      end)

      return true
    end,
  }):find()
end

-- Setup on startup
function M.setup(opts)
  config.setup(opts)
  vim.schedule(function()
    config.load_state()
    M.apply(config.current)
  end)
end

return M