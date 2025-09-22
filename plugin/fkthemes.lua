-- Auto load current theme
require("fkthemes").setup()

-- Commands
vim.api.nvim_create_user_command("FkThemeNext", function()
  require("fkthemes").next()
end, {})

vim.api.nvim_create_user_command("FkTheme", function(opts)
  require("fkthemes").set(opts.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("FkThemePicker", function()
  require("fkthemes").telescope_picker()
end, {})

