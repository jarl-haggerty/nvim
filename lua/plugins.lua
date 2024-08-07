vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }

  use {
    "williamboman/mason.nvim"
  }

  --use {
  --  'VonHeikemen/lsp-zero.nvim',
  --  branch = 'v2.x',
  --  requires = {
  --    -- LSP Support
  --    {'neovim/nvim-lspconfig'},             -- Required
  --    {                                      -- Optional
  --      'williamboman/mason.nvim',
  --      run = function()
  --        pcall(vim.api.nvim_command, 'MasonUpdate')
  --      end,
  --    },
  --    {'williamboman/mason-lspconfig.nvim'}, -- Optional
  --
  --    -- Autocompletion
  --    {'hrsh7th/nvim-cmp'},     -- Required
  --    {'hrsh7th/cmp-nvim-lsp'}, -- Required
  --    {'L3MON4D3/LuaSnip'},     -- Required
  --  }
  --}

  use 'mfussenegger/nvim-dap'

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }

  use {'hrsh7th/nvim-cmp'}     -- Required
  use {'hrsh7th/cmp-nvim-lsp'} -- Required
  use {'folke/trouble.nvim'}
end)
