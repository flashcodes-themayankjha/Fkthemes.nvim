# 🎨 FkThemes.nvim

`FkThemes.nvim` is a Neovim plugin for seamless theme management, allowing you to easily switch, preview, and configure your favorite color schemes with a modern UI.

## ✨ Features

- 🔄 **Easy Theme Switching**: Quickly change between your configured themes.
- 👁️ **Live Theme Preview**: See how themes look before applying them.
- ⚙️ **User-Configurable**: Define your themes and their settings.
- 🚀 **Modern UI**: Utilizes `nui.nvim` for a sleek and interactive theme picker.
- 🔭 **Telescope Integration**: Seamlessly select themes using `telescope.nvim`.

## 📋 Requirements

- Neovim >= **0.8.0**
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## 📦 Installation

Install the plugin with your preferred package manager:

[lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "flashcodes-themayankjha/Fkthemes.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    -- Add Your Desired themes as dependencies

  },
  config = function()
    require("fkthemes").setup({
      -- Your configuration goes here
      -- For example:
      -- themes = {
      --   "catppuccin",
      --   "tokyonight",
      --   "dracula",
      -- },
      -- keymaps = {
      --   enable = true, -- Set to false to disable all default keymaps
      --   open_picker = {
      --     lhs = "<leader>th",
      --     rhs = "<cmd>FkThemePicker<cr>",
      --     mode = "n",
      --     desc = "Open FkThemes Picker",
      --   },
      --   next_theme = {
      --     lhs = "<leader>tn",
      --     rhs = "<cmd>FkThemeNext<cr>",
      --     mode = "n",
      --     desc = "Cycle to Next FkTheme",
      --   },
      -- },
    })
  end,
}
```

## ⚙️ Configuration

`FkThemes.nvim` is highly configurable. You can pass your options to the `setup()` function.

<details><summary>Default Settings</summary>

```lua
{
  transparent_background = false, -- Whether to set background to transparent for UI components.
  themes = {
    "tokyonight",
    "catppuccin",
    "gruvbox",
    "rose-pine",
    "material",
    "moonlight",
  },
  default_theme = "tokyonight", -- The theme to apply on startup if no state is saved.
  keymaps = {
    enable = true, -- Set to false to disable all default keymaps created by the plugin.
    open_picker = {
      lhs = "<leader>tp",
      rhs = "<cmd>FkThemePicker<cr>",
      mode = "n",
      desc = "Open FkThemes Picker",
    },
    next_theme = {
      lhs = "<leader>tn",
      rhs = "<cmd>FkThemeNext<cr>",
      mode = "n",
      desc = "Cycle to Next FkTheme",
    },
    -- You can add or override keymaps here.
    -- For example, to change the 'open_picker' keybinding:
    -- open_picker = {
    --   lhs = "<leader>T",
    --   rhs = "<cmd>FkThemePicker<cr>",
    --   mode = "n",
    --   desc = "Open FkThemes Picker (Custom)",
    -- },
  },
}
```

</details>

## 🚀 Usage

- **Open Theme Picker**: Use the `:FkThemes` command to open the theme selection interface.
  - If you've set up the keybinding as shown in the installation, you can use `<leader>tp`.
- **Select Theme**: Navigate through the list of themes and press `<CR>` to apply a theme.
- **Preview Theme**: The theme will be applied live as you navigate, allowing for instant preview.

## 💡 Examples

### Basic Configuration

```lua
require("fkthemes").setup({
  themes = {
    "catppuccin",
    "tokyonight",
    "dracula",
    "nord",
  },
})
```

### Configuring Light and Dark Themes

You can define different sets of themes and switch between them.

```lua
require("fkthemes").setup({
  themes = {
    light = { "github_light", "solarized_light" },
    dark = { "catppuccin", "tokyonight", "dracula" },
  },
  -- You might want to add a custom command or function to switch between light/dark sets
  -- For example, a command to load a specific set:
  -- vim.api.nvim_create_user_command("FkThemesLight", function()
  --   require("fkthemes").load_theme_set("light")
  -- end, { desc = "Load Light Themes" })
})
```

## 📦 Alternatives

- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) (a theme, but often used as a base for theme management)
- [lunarvim/lunar.nvim](https://github.com/lunarvim/lunar.nvim) (a distribution with theme management)
- [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) (for color highlighting, not theme management)
