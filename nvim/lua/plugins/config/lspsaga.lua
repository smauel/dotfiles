local saga = require 'lspsaga'

saga.init_lsp_saga {
  finder_action_keys = {
    open = {'<CR>', 'o'}, vsplit = 's',split = 'i',quit = {'q', '<esc>', '<C-c>'},
    scroll_down = '<C-f>',scroll_up = '<C-b>'
  },
  code_action_keys = {
    quit = {'q', '<esc>', '<C-c>'}, exec = '<CR>'
  },
  rename_action_keys = {
    quit = {'<esc>', '<C-c>'}, exec = '<CR>'
  },
}
