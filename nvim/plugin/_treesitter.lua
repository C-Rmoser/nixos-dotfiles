
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "help", "javascript", "typescript", "c", "lua", "vim", "rust", "yaml", "json" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

