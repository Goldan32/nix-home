return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    on_colors = function(colors)
      colors.bg = '#202020'
      colors.bg_statusline = '#202020'
      colors.bg_sidebar = '#1a1a1a'
    end,
  },
  init = function()
    vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
