
vim.api.nvim_set_keymap(
    'n',
    'C-s',
    [[gg/public<Enter>jvi(:g/\|/d<Enter>vi(:sort /<\(.*\.\\|.\{-\}__\)/<Enter>vi(:s/\n/\r\t\|\r<Enter>kdd:nohl<Enter>']],
    { noremap = true }
)
