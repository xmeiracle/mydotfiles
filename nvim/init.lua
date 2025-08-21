-- Lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip"
    }
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",      -- Python
          "ts_ls",     -- JavaScript / TypeScript
          "html",         -- HTML
          "cssls",        -- CSS
          "clangd",       -- C / C++
          "jdtls",        -- Java
          "lua_ls",       -- Lua
          "gopls",        -- Go
          "rust_analyzer" -- Rust
        }
      })

      local lspconfig = require("lspconfig")
      local servers = {
        "pyright", "ts_ls", "html", "cssls",
        "clangd", "jdtls", "lua_ls", "gopls", "rust_analyzer"
      }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({})
      end
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- Discord Presence
  {
    "andweeb/presence.nvim",
    config = function()
      require("presence").setup({
        auto_update = true,
        neovim_image_text = "The One True Text Editor",
        main_image = "file", -- "neovim" or "file"
        log_level = nil,
        debounce_timeout = 10,
        enable_line_number = true,
        blacklist = {},
        buttons = true,
        file_assets = {},
        show_time = true,
      })
    end
  }
})

-- CMP setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
})

-- UI settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative numbers

