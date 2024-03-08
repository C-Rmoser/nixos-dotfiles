require("bufferline").setup({
	highlights = {
		offset_separator = {
			fg = '#495156',
			bg = '#272E33'
		},
	},
	options = {
		numbers = 'ordinal',
		max_name_length = 35,
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				separator = true,
			}
		}
	},
})

vim.keymap.set('n', '<leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>,', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>.', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader><', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>>', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>wa', '<Cmd>BufferLineCloseRight<CR><Cmd>BufferLineCloseLeft<CR>',
	{ noremap = true, silent = true })
