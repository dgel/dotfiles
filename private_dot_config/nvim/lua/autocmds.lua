
-- TODO: move to lua api once updated to stable nvim 0.7.0

vim.cmd([[autocmd BufReadPre *.vcxproj set filetype=xml]])
vim.cmd([[autocmd BufReadPre *.vcxproj.filters set filetype=xml]])

vim.cmd([[autocmd BufRead *.{jsgf} set filetype=jsgf]])
vim.cmd([[autocmd BufRead *.{jsgf} set noexpandtab]])
vim.cmd([[autocmd BufRead *.{fas,wfas,annostring,weightedfieldannotatedstring,fieldannotatedstring,annotatedstring} set filetype=wfas noexpandtab]])

