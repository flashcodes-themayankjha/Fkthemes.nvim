
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
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "BufferLineFill",
    "BufferLineBackground",
    "StatusLine",
    "StatusLineNC",
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
    "WinSeparator",
    "VertSplit",
    "SignColumn",
    "CursorLineNr",
    "BufferLineSeparator",
    "ToolbarLine",
    "BufferLineFill",
    "WhichKeyFloat",
    "NvimTreeNormal",
    "NotifyWARNBody3",
    "NotifyWARNTitle3",
    "NotifyWARNBorder3",
    "NotifyWARNIcon3",
    "BufferLineTab",
    "BufferLineDuplicate",
    "BufferLineDuplicateVisible",
  }

  for _, hl in ipairs(highlights) do
    vim.api.nvim_set_hl(0, hl, { bg = "none" })
  end
end

-- Re-apply transparency after any colorscheme load
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if config.options.transparent_background then
      apply_transparency()
    end
  end,
})

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
      vim.notify("Fkthemes: colorscheme '" .. theme .. "' not installed!", vim.log.levels.WARN)
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
  vim.notify("Fkthemes: Theme '" .. name .. "' not found!", vim.log.levels.WARN)
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

  -- Save the current CursorLine background color before changing it
  local cursor_line_bg = vim.api.nvim_get_hl_by_name("CursorLine", true).background

  -- Disable CursorLine highlight while the picker is open
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
  vim.opt_local.cursorline = false

  if config.options.transparent_background then
    apply_transparency()
  end

  pickers.new({}, {
    prompt_title = "🎨 FkThemes",
    finder = finders.new_table { results = config.options.themes },
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function preview_current()
        local entry = action_state.get_selected_entry()
        if entry then
          M.set(entry[1])
        end
      end

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

  -- Restore CursorLine highlight after the picker is closed
  vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "TelescopePrompt",
    once = true,
    callback = function()
      vim.api.nvim_set_hl(0, "CursorLine", { bg = cursor_line_bg })
    end,
  })
end

-- Setup on startup
function M.setup(opts)
  config.setup(opts)

  if config.options.keymaps.enable then
    for _, keymap_opts in pairs(config.options.keymaps) do
      if type(keymap_opts) == "table" and keymap_opts.lhs and keymap_opts.rhs and keymap_opts.mode then
        vim.keymap.set(keymap_opts.mode, keymap_opts.lhs, keymap_opts.rhs, { desc = keymap_opts.desc })
      end
    end
  end

  -- Disable cursorline and CursorLine highlight in Neo-tree buffers
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "neo-tree",
    callback = function()
      vim.opt_local.cursorline = false
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    end,
  })

  -- Restore CursorLine highlight after leaving Neo-tree buffer (adjust color as needed)
  vim.api.nvim_create_autocmd("BufWinLeave", {
    pattern = "*",
    callback = function()
      if vim.bo.filetype == "neo-tree" then
        -- Replace with your colorscheme's original cursorline bg color
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2a2a2a" })
      end
    end,
  })

  -- Disable cursorline and CursorLine highlight in TelescopePrompt buffers
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopePrompt",
    callback = function()
      vim.opt_local.cursorline = false
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    end,
  })

  vim.schedule(function()
    config.load_state()
    M.apply(config.current)
  end)
end

return M
