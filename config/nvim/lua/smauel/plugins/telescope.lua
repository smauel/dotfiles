local Util = require("smauel.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("fzf")
      require('telescope').load_extension('aerial')
    end,
    opts = {
      defaults = {
        mappings = {
          i = {
                ["<esc>"] = require("telescope.actions").close,
                ['<C-u>'] = false,
                ['<C-d>'] = false,
          },
        },
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
      extensions = {
            ["ui-select"] = {
          require("telescope.themes").get_dropdown {
          }
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
      }
    },
    keys = {
      { "<leader>,",  ":Telescope aerial<CR>",                                  desc = "Telescope Outline" },
      { "<leader>?",  ":Telescope resume<CR>",                                  desc = "Telescope Resume" },
      { "<leader>b",  Util.telescope("buffers"),                                desc = "Telescope Buffers" },
      { "<leader>gb", Util.telescope("git_branches"),                           desc = "Telescope Git Branches" },
      { "<leader>gc", Util.telescope("git_commits"),                            desc = "Telescope Git Commits" },
      { "<leader>gf", Util.telescope("git_files"),                              desc = "Telescope Git Files" },
      { "<leader>gs", Util.telescope("git_status"),                             desc = "Telescope Git Status" },
      { "<leader>h",  Util.telescope("help_tags"),                              desc = "Telescope Help" },
      { "<leader>k",  Util.telescope("keymaps"),                                desc = "Telescope Keymaps" },
      { "<leader>p",  Util.telescope("files"),                                  desc = "Telescope Files" },
      { "<leader>q",  Util.telescope("quickfix"),                               desc = "Telescope Quickfix" },
      { "<leader>r",  Util.telescope("live_grep"),                              desc = "Telescope Grep" },
      { "<leader>x",  Util.telescope("command_history"),                        desc = "Telescope Command History" },
      { "<leader>z",  Util.telescope("colorscheme", { enable_preview = true }), desc = "Telescope Colorschemes" },
    }
  },
}
