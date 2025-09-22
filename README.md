# FkThemes.nvim

A Neovim plugin for managing and switching themes with ease, featuring Telescope integration for live preview and transparency support.

## Features

*   **Theme Switching:** Easily cycle through themes or set a theme by name.
*   **Telescope Integration:** A beautiful Telescope picker with live theme preview as you navigate.
*   **Transparency Support:** Configure your themes to have a transparent background.

## Installation

Install with your favorite plugin manager.

### lazy.nvim

```lua
{
  'flashcodes-themayankjha/Fkthemes.nvim',
  name = 'fkthemes',
  config = function()
    require('fkthemes').setup()
  end,
}
```

## Configuration

You can configure `FkThemes.nvim` by passing an options table to the `setup()` function in your `init.lua` or any other configuration file.

```lua
require('fkthemes').setup({
  -- Set to true to enable transparent background for your themes
  transparent_background = false,

  -- List of themes to manage. Ensure these themes are installed.
  themes = {
    "tokyonight",
    "catppuccin",
    "gruvbox",
    "rose-pine",
    "onedark",
    -- Add more themes as you install them
  },

  -- Specify the default theme to load on startup
  default_theme = "tokyonight",
})
```

### Options

*   `transparent_background` (boolean, default: `false`):
    If `true`, the plugin will attempt to set the Neovim background to transparent. For full transparency, ensure your terminal emulator also supports transparency and is configured accordingly.

*   `themes` (table, default: `{"tokyonight", "catppuccin", ...}`):
    A list of theme names (strings) that `FkThemes.nvim` will manage. Ensure that all themes listed here are installed in your Neovim environment.

*   `default_theme` (string, default: `"tokyonight"`):
    The name of the theme to load when Neovim starts up. This theme must be present in the `themes` list.

## Usage

### Commands

*   `:FkthemeNext`: Cycles to the next theme in your configured list.
*   `:FkTheme <theme_name>`: Sets a specific theme by its name (e.g., `:FkTheme catppuccin`).
*   `:FkthemePicker`: Opens the Telescope picker for interactive theme selection with live preview.

### Keybindings (Example)

You can set up keybindings for quick access to FkThemes functionality:

```lua
vim.keymap.set('n', '<leader>tn', ':FkthemeNext<CR>', { desc = 'Next FkTheme' })
vim.keymap.set('n', '<leader>tp', ':FkthemePicker<CR>', { desc = 'Pick FkTheme' })
```
