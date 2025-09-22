
# 🎨 FkThemes.nvim

[![Neovim](https://img.shields.io/badge/Neovim-0.8+-57A143?logo=neovim&logoColor=white)](https://neovim.io)  
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

**FkThemes.nvim** is a modern Neovim plugin for **theme management**.  
Easily switch, preview, and configure multiple colorschemes with a sleek UI powered by [nui.nvim](https://github.com/MunifTanjim/nui.nvim) and [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

---

## ✨ Features

- 🔄 **Quick Theme Switching** – Move between themes effortlessly.  
- 👁️ **Live Preview** – Preview themes instantly as you navigate.  
- ⚙️ **Highly Configurable** – Customize transparency, themes, and keymaps.  
- 🚀 **Modern UI** – Built with `nui.nvim`.  
- 🔭 **Telescope Integration** – Theme selection inside Telescope.  

---

## 📋 Requirements

- Neovim **>= 0.8.0**  
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)  
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

---

## 📦 Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "flashcodes-themayankjha/Fkthemes.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    -- Add your themes here
  },
  config = function()
    require("fkthemes").setup({
      themes = { "tokyonight", "catppuccin", "gruvbox" },
      default_theme = "tokyonight",
      transparent_background = true,
    })
  end,
}
````

---

## ⚙️ Configuration

Customize `setup()` with your options.

<details>
<summary>Default Settings</summary>

```lua
{
  transparent_background = false, -- Transparent UI
  themes = {
    "tokyonight",
    "catppuccin",
    "gruvbox",
    "rose-pine",
    "material",
    "moonlight",
  },
  default_theme = "tokyonight",
  keymaps = {
    enable = true, -- Disable to remove default keymaps
    open_picker = {
      lhs = "<leader>tp",
      rhs = "<cmd>FkThemePicker<cr>",
      mode = "n",
      desc = "Open Theme Picker",
    },
    next_theme = {
      lhs = "<leader>tn",
      rhs = "<cmd>FkThemeNext<cr>",
      mode = "n",
      desc = "Next Theme",
    },
  },
}
```

</details>

---

### 🎨 Example with Transparency Support

Some themes allow native transparency. Configure them as dependencies:

```lua
dependencies = {
  "nvim-telescope/telescope.nvim",

  -- Material
  "marko-cerovac/material.nvim",

  -- Tokyonight
  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
    end,
  },

  -- Rose Pine
  { "rose-pine/neovim", name = "rose-pine" },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
    end,
  },

  -- Others
  "shaunsingh/moonlight.nvim",
  "morhetz/gruvbox",
}
```

---

## 🚀 Usage

* **Open Theme Picker** → `:FkThemes` or `<leader>tp`
* **Next Theme** → `:FkThemeNext` or `<leader>tn`
* **Preview Live** → Navigate themes inside the picker

---

## 💡 Examples

### Basic

```lua
require("fkthemes").setup({
  themes = { "catppuccin", "tokyonight", "dracula" },
})
```

### Light/Dark Sets

```lua
require("fkthemes").setup({
  themes = {
    light = { "github_light", "solarized_light" },
    dark  = { "catppuccin", "tokyonight", "dracula" },
  },
})

-- Optional command
vim.api.nvim_create_user_command("FkThemesLight", function()
  require("fkthemes").load_theme_set("light")
end, { desc = "Load Light Themes" })
```

---

## 📦 Alternatives

* [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim) – Single theme
* [lunarvim/lunar.nvim](https://github.com/lunarvim/lunar.nvim) – Distribution with theme switching
* [NvChad/nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua) – Highlighting, not theme management

---

## 🛠️ Contributing

Contributions are welcome!
Feel free to open **issues** or submit **PRs** for new features, theme presets, or improvements.

---

## 📜 License

This project is licensed under the [MIT License](./LICENSE).

