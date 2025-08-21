-- ~/.config/nvim/lua/plugins.lua
return require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Auto-completion engine
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'L3MON4D3/LuaSnip'       -- Snippets

  -- Language Server Protocol (LSP)
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- Treesitter (for better syntax highlighting)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'  -- Auto-update parsers
  }
end)
