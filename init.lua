vim.g.mapleader = " "
vim.cmd("colorscheme slate")
vim.opt.colorcolumn = "119"
vim.opt.hlsearch = true
vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

require("mason").setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "javascript", "typescript", "c", "cpp", "lua", "python", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

local cmp = require'cmp'

cmp.setup {
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = cmp.mapping.preset.insert()
}

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.format, {})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {})
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = true

    vim.lsp.start({
      name = 'pyright',
      cmd = {'pyright-langserver', '--stdio'},
      root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
      capabilities = capabilities,
    })
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"cpp", "c"},
	callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = true

    vim.lsp.start({
      name = 'clangd',
      cmd = {'clangd'},
      root_dir = vim.fs.dirname(vim.fs.find({'CMakeLists.txt'}, { upward = true })[1]),
      capabilities = capabilities,
    })
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"typescript", "javascript"},
	callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.smartindent = true

    vim.lsp.start({
      name = 'typescript-language-server',
      cmd = {'typescript-language-server', '--stdio'},
      root_dir = vim.fs.dirname(vim.fs.find({'package.json'}, { upward = true })[1]),
    })
	end
})

local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
	{
		type="python";
		request="launch";
		name="ophanim";
		module="bmbi.ophanim";
	},
	{
		type="python";
		request="launch";
		name="thalamus";
		module="bmbi.thalamus";
    args={"--config", "task_controller_config.json"}
	}
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'C:\\Users\\jarl\\extension\\debugAdapters\\bin\\OpenDebugAD7',
  options = {
    detached = false
  }
}

dap.adapters.lldb = {
  id = 'lldb',
  type = 'executable',
  command = 'C:\\Program Files\\LLVM\\bin\\lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    program = "C:\\bmbi\\bmbi\\bmbi_native.exe",
    args = {"thalamus", "--slave"},
    stopOnEntry = false,
    runInTerminal = true
  },
}

require("trouble").setup()
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>')
