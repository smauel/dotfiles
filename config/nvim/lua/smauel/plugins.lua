-- ensure packer is installed
local is_bootstrap = false
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

-- auto compile when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'
    use 'navarasu/onedark.nvim'


    use {
      'neovim/nvim-lspconfig',
      requires = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'jayp0521/mason-null-ls.nvim',
        'j-hui/fidget.nvim',
        'lukas-reineke/lsp-format.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jose-elias-alvarez/typescript.nvim',
      },
    }

    use {
      'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
      config = function()
        pcall(require('smauel.config.cmp'))
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        pcall(require('nvim-treesitter.install').update { with_sync = true })
      end,
      config = function()
        pcall(require('smauel.config.treesitter'))
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
    }

    use {
      'b0o/mapx.nvim',
      requires = { 'folke/which-key.nvim' },
    }

    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        pcall(require('smauel.config.nvimtree'))
      end,
    }

    use {
      'nvim-lualine/lualine.nvim',
      config = function()
        pcall(require('smauel.config.lualine'))
      end
    }

    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        pcall(require('smauel.config.gitsigns'))
      end
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        pcall(require('smauel.config.indent_blankline'))
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-ui-select.nvim',
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make',
          cond = vim.fn.executable 'make' == 1
        }
      }
    }

    use {
      'windwp/nvim-autopairs',
      config = function()
        pcall(require('smauel.config.autopairs'))
      end
    }

    use {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup()
      end,
    }

    if is_bootstrap then
      require('packer').sync()
    end
  end,

  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
