vim.o.background = 'dark'
vim.cmd.colorscheme("gruvbox-material")

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "Error" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { link = "WarningMsg" })
