-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = ","

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

local function telescope_live_grep(_)
  require("lvim.core.nvimtree").start_telescope "live_grep"
end

local function telescope_quick_open()
  local opts = require("telescope.themes").get_dropdown({
    prompt_title = "Open...",
    winblend = 10,
    width = 0.5,
    previewer = false,
    results_height = 15,
  })
  require("telescope.builtin").fd(opts)
end

lvim.builtin.nvimtree.setup.view.mappings.list = {
  { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
  { key = "h", action = "close_node" },
  { key = "v", action = "vsplit" },
  { key = "C", action = "cd" },
  { key = "f", action = "telescope_live_grep", action_cb = telescope_live_grep },
}

lvim.builtin.which_key.mappings = {
  ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", "💬 Toggle Comment" },
  ["h"] = { "<cmd>nohlsearch<CR>", "🔦 Toggle Highlight" },
  ["k"] = { "<cmd>NvimTreeFocus<CR>", "🎯 Find in Explorer" },
  ["l"] = { "<cmd>NvimTreeToggle<CR>", "📁 Explorer" },
  -- ["p"] = { "<cmd>Telescope find_files previewer=false results_height=15<cr>", "Find File" },
  ["p"] = { telescope_quick_open, "⏩ Quick Open" },
  ["q"] = { "<cmd>lua require('lvim.utils.functions').smart_quit()<CR>", "😿 Quit" },
  ["w"] = { "<cmd>w!<CR>", "💾 Save" },
  b = {
    name = " 📚 Buffers",
    b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
    d = { "<cmd>BufferKill<CR>", "Close Buffer" },
    e = {
      "<cmd>BufferLinePickClose<cr>",
      "Pick which buffer to close",
    },
    f = { "<cmd>Telescope buffers<cr>", "Find" },
    j = { "<cmd>BufferLinePick<cr>", "Jump" },
    h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
    l = {
      "<cmd>BufferLineCloseRight<cr>",
      "Close all to the right",
    },
    D = {
      "<cmd>BufferLineSortByDirectory<cr>",
      "Sort by directory",
    },
    L = {
      "<cmd>BufferLineSortByExtension<cr>",
      "Sort by language",
    },
  },
  c = {
    name = " 🪛 Code",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    p = {
      name = "Peek",
      d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
      t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
      i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
    },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
  },
  f = {
    name = " 🔍 Find",
    a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find All" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
  },

  -- " Available Debug Adapters:
  -- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
  -- " Adapter configuration and installation instructions:
  -- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  -- " Debug Adapter protocol:
  -- "   https://microsoft.github.io/debug-adapter-protocol/
  -- " Debugging
  g = {
    name = " 😺 Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>DiffviewOpen<cr>", "Open Diff" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    x = { "<cmd>DiffviewClose<cr>", "Close Diff" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  },
  t = {
    name = " 🧪 Tests",
    t = { function() require("neotest").run.run(vim.fn.expand("%")) end, "Run all in file" },
    n = { function() require("neotest").run.run() end, "Run nearest" },
    s = { function() require("neotest").summary.toggle() end, "Summary" },
  },
  u = {
    name = " 🚀 Update",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update Packer" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
  },
  [";"] = {
    name = " 📊 Settings",
    c = {
      "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
      "Edit config.lua",
    },
    f = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "Find LunarVim files",
    },
    g = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
      "Grep LunarVim files",
    },
    i = {
      "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
      "Toggle LunarVim Info",
    },
    k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
    l = {
      name = "+logs",
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "view default log",
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        "Open the default logfile",
      },
      l = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
        "view lsp log",
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        "view neovim log",
      },
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      p = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(get_cache_dir() .. '/packer.nvim.log')<cr>",
        "view packer log",
      },
      P = { "<cmd>edit $LUNARVIM_CACHE_DIR/packer.nvim.log<cr>", "Open the Packer logfile" },
    },
    n = { "<cmd>Telescope notify<cr>", "View Notifications" },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
  },
}

local function startify_sections()
  local header = {
    type = "text",
    val = {
      [[Quickstart]]
    },
    opts = {
      hl = "Label",
      shrink_margin = false,
    },
  }

  local top_buttons = {
    entries = {},
    val = {},
  }

  local bottom_buttons = {
    entries = {},
    val = {},
  }

  local footer = {
    type = "group",
    val = {},
  }

  return {
    header = header,
    top_buttons = top_buttons,
    bottom_buttons = bottom_buttons,
    -- this is probably broken
    footer = footer,
  }
end

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "startify"
lvim.builtin.alpha.startify.section = startify_sections()
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "comment",
  "css",
  "dockerfile",
  "go",
  "graphql",
  "hcl",
  "html",
  "http",
  "javascript",
  "json",
  "lua",
  "make",
  "markdown",
  "tsx",
  "typescript",
  "vue",
  "yaml",
}
lvim.builtin.treesitter.highlight.enabled = true

-- null-ls
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "eslint_d" },
  { name = "gitsigns" },
  { name = "refactoring" },
  { name = "shellcheck" },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { name = "codespell" },
  { name = "actionlint" },
  { name = "checkmake" },
  { name = "eslint_d" },
  { name = "gitlint" },
  { name = "golangci_lint" },
  { name = "hadolint" },
  { name = "jsonlint" },
  { name = "luacheck" },
  { name = "markdownlint" },
  { name = "shellcheck" },
  -- { name = "yamllint" },
  { command = "sqlfluff", extra_args = { "--dialect", "postgres" } },
}
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { name = "codespell" },
  -- { name = "eslint_d" },
  { name = "fixjson" },
  { name = "gofmt" },
  { name = "goimports" },
  { name = "markdownlint" },
  { name = "prettierd" },
  { name = "terraform_fmt" },
  -- { name = "trim_newlines" },
  -- { name = "trim_whitespace" },
  { command = "sqlfluff", extra_args = { "--dialect", "postgres" } },
}

-- plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "tpope/vim-surround",
    keys = { "c", "d", "y" }
  },
  { "tpope/vim-repeat" },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup({
        keywords = {
          FIX = { icon = " ", color = "warning", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        }
      })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    config = function()
      require("diffview").setup({
        file_panel = {
          listing_style = "list",
          win_config = {
            type = "split",
            position = "bottom",
            height = 10,
          },
        }
      })
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-go"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
          require("neotest-jest"),
          require("neotest-plenary"),
        },
      })
    end
  }
}

-- autocmds
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
