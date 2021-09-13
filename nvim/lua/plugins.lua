-- ensure packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

-- auto compile when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'
  use 'editorconfig/editorconfig-vim'

  use 'tmux-plugins/vim-tmux-focus-events'
  use 'christoomey/vim-tmux-navigator'

  -- tpope plugins TODO: which of these do I actually use?
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-ragtag'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'

  use {
    'neoclide/coc.nvim', branch = 'release',
    requires = { 'honza/vim-snippets', opt = true }
  }

  use 'nvim-lua/popup.nvim'

  use {
    'hoob3rt/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.lualine') end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim'},
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'fannheyward/telescope-coc.nvim' }
    },
    config = function() require('config.telescope') end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('config.nvimtree') end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('config.autopairs') end
  }

  use {
    'rcarriga/vim-ultest',
    run = ':UpdateRemotePlugins',
    requires = {
      { 'vim-test/vim-test' },
      { 'voldikss/vim-floaterm' }
    },
    config = function() require('config.ultest') end
  }

  use {
    'b0o/mapx.nvim',
    requires = { 'folke/which-key.nvim' }
  }

  -- TODO: figure out how to use
  use {
    'pwntester/octo.nvim',
    requires = {{ 'nvim-telescope/telescope.nvim' }, { 'kyazdani42/nvim-web-devicons' }},
    config = function() require('config.octo') end
  }

  -- TODO: figure out how to use
  use {
    'nvim-neorg/neorg',
    requires = {{ 'nvim-lua/plenary.nvim' }, { 'nvim-neorg/neorg-telescope'} },
    config = function() require('config.neorg') end
  }

  -- colorschemes
  use 'tjdevries/colorbuddy.vim'
  use 'shaunsingh/nord.nvim'
  use 'sainnhe/gruvbox-material'
  use 'sainnhe/everforest'
  use 'bluz71/vim-moonfly-colors'
  use 'kyazdani42/blue-moon'
  use { 'rockerBOO/boo-colorscheme-nvim', branch = 'main' }
  use 'bkegley/gloombuddy'
  use 'fenetikm/falcon'
  use 'shaunsingh/moonlight.nvim'
  use 'nxvu699134/vn-night.nvim'
  use 'kdheepak/monochrome.nvim'
  use 'rose-pine/neovim'
  use 'EdenEast/nightfox.nvim'
  use { 'mcchrish/zenbones.nvim', requires = { 'rktjmp/lush.nvim', opt = true} }
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
