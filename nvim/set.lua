local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
		group = 'YankHighlight',
		callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '100' })
		end
})

-- vim.o.guicursor = 'i:block'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.list = false
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.smartindent = false

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 800

vim.opt.colorcolumn = "140"

vim.opt.clipboard = "unnamedplus"

vim.opt.fixendofline = false

vim.opt.textwidth = 0

autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.yaml,*.yml,*.nix",
        callback = function()
            vim.opt.tabstop = 2
            vim.opt.shiftwidth = 2
            vim.opt.softtabstop = 4
        end
    }
)
