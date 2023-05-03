return {
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
  },
  {
    "jesseleite/nvim-noirbuddy",
    event = "VeryLazy",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
      branch = "dev",
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    event = "VeryLazy",
  },
  {
    "bluz71/vim-moonfly-colors",
    event = "VeryLazy",
  },
  {
    "bluz71/vim-nightfly-colors",
    event = "VeryLazy",
  },
  {
    "Everblush/nvim",
    event = "VeryLazy",
  },
  {
    "JoosepAlviste/palenightfall.nvim",
    event = "VeryLazy",
  },
  {
    "yonlu/omni.vim",
    event = "VeryLazy",
  },
  {
    "Abstract-IDE/Abstract-cs",
    event = "VeryLazy",
  },
  {
    "Mofiqul/dracula.nvim",
    event = "VeryLazy",
  },
  {
    "mcchrish/zenbones.nvim",
    event = "VeryLazy",
    dependencies = {
      "rktjmp/lush.nvim",
    },
  },
  {
    "LunarVim/horizon.nvim",
    event = "VeryLazy",
  },
  {
    "LunarVim/synthwave84.nvim",
    event = "VeryLazy",
  },
  {
    "katawful/kat.nvim",
    event = "VeryLazy",
  },
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
  },
  {
    "hachy/eva01.vim",
    event = "VeryLazy",
  },
  {
    "igorgue/danger",
    event = "VeryLazy",
  },
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
  },
  {
    "arturgoms/moonbow.nvim",
    event = "VeryLazy",
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
    opts = {
      palette_overrides = {},
    },
  },
  {
    "ray-x/starry.nvim",
    event = "VeryLazy",
  },
  {
    "ray-x/aurora",
    event = "VeryLazy",
  },

  -- set default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
