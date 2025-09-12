vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>w', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Custom keymaps
vim.keymap.set('n', '-', '$')
vim.keymap.set('v', '-', '$')
vim.keymap.set('n', '<C-l>', 'w', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', 'B', { noremap = true, silent = true })
vim.keymap.set('v', '<C-l>', 'w', { noremap = true, silent = true })
vim.keymap.set('v', '<C-h>', 'B', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '{', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '}', { noremap = true, silent = true })
vim.keymap.set('v', '<C-k>', '{', { noremap = true, silent = true })
vim.keymap.set('v', '<C-j>', '}', { noremap = true, silent = true })
vim.keymap.set('n', '[t', 'gT', { noremap = true, silent = true })
vim.keymap.set('n', ']t', 'gt', { noremap = true, silent = true })
vim.keymap.set('n', 'tt', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>g', ':GitBlameToggle<CR>', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<leader>h', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>l', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>j', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>k', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
