
<div align="center">

#  🎨 fkthemes.nvim

**A simple yet powerful theme previewer and Selector plugin for Neovim, inspired by the FkVim ecosystem.**

<a href="https://github.com/TheFlashCodes/FKvim">
  <img src="https://img.shields.io/badge/FkVim-Ecosystem-blueviolet.svg?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTkuODYgMy41bDIuNjcgMy43NEwxNC40OCAzLjVoMy41MkwxMiAxMy4yOCAzLjk4IDMuNWg5Ljg4ek0xMiAxNS4wNGwtMy44NyA1LjQ2aDcuNzVsLTMuODgtNS40NnoiIGZpbGw9IiNmZmYiLz48L3N2Zz4=" alt="FkVim Ecosystem"/>
</a>

</div>

<p align="center">
  <img src="https://img.shields.io/badge/Made%20with-Lua-blue.svg?style=for-the-badge&logo=lua" />
  <img src="https://img.shields.io/badge/Powered%20by-Neovim-green.svg?style=for-the-badge&logo=neovim" />
  <a href="https://github.com/flashcodes-themayankjha/Fkthemes.nvim/stargazers"><img src="https://img.shields.io/github/stars/flashcodes-themayankjha/Fkthemes.nvim?style=for-the-badge" /></a>
  <a href="https://github.com/flashcodes-themayankjha/Fkthemes.nvim/blob/main/LICENSE"><img src="https://img.shields.io/github/license/flashcodes-themayankjha/Fkthemes.nvim?style=for-the-badge" /></a>
</p>

> **fkthemes.nvim** is a modern Neovim plugin for **theme management**.  
Easily switch, preview, and configure multiple colorschemes with a sleek UI powered by [nui.nvim](https://github.com/MunifTanjim/nui.nvim) and [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).

<img width="1698" height="1035" alt="image" src="https://github.com/user-attachments/assets/a5b508a2-b481-47a7-aea8-b814e717d6f6" />
</br>

---

<img width="3260" height="1534" alt="FkThemes" src="https://github.com/user-attachments/assets/b7056815-3a18-4c13-bde3-058dfffc2019" />




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
  "flashcodes-themayankjha/fkthemes.nvim",
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

<img width="2396" height="1560" alt="FkThemesTrans" src="https://github.com/user-attachments/assets/9cbabb91-fcdd-4d35-a19c-c645e290db0d" />


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

> **Note**
> Transparency only works properly if your chosen theme supports it.  
> For the best transparency experience, use **fkthemes.nvim** with [Fkvim](https://fkvim.netlify.app/).

---

## 🚀 Usage

* **Open Theme Picker** → `:FkThemePicker` or `<leader>tp`
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

