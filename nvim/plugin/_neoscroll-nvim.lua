require('neoscroll').setup({
    mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
})

local t    = {}
t['<c-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '80' } }
t['<c-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '80' } }
t['zt']    = { 'zt', { '80' } }
t['zz']    = { 'zz', { '80' } }
t['zb']    = { 'zb', { '80' } }

require('neoscroll.config').set_mappings(t)
