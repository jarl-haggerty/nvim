vim.g.mapleader = " "
vim.cmd("colorscheme desert")
vim.opt.colorcolumn = "119"
vim.opt.hlsearch = true
vim.wo.number = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

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
    })
	end
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {"*.cpp", "*.cc", "*.c", "*.h", "*.hpp"},
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
    })
	end
})
