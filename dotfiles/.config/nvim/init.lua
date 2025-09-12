require 'options'
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins you can run
--    :Lazy update

-- NOTE: Plugins
require('lazy').setup({
  require 'plugins.autocompletion',
  require 'plugins.autoformat',
  require 'plugins.autopairs',
  require 'plugins.comment',
  require 'plugins.cutlass',
  require 'plugins.debug',
  require 'plugins.gitsigns',
  require 'plugins.indent-line',
  require 'plugins.lint',
  require 'plugins.lsp',
  require 'plugins.neo-tree',
  require 'plugins.small-plugins',
  require 'plugins.tabstop',
  require 'plugins.telescope',
  require 'plugins.theme',
  require 'plugins.todo-comment',
  require 'plugins.treesitter',
  require 'plugins.which-key',
  require 'plugins.git-blame',
  require 'plugins.leap',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
