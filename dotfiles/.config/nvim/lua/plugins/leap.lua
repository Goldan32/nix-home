return {
  'ggandor/leap.nvim',
  lazy = false,
  config = function()
    -- print '---INFO: Starting leap.nvim config ---'

    local status_ok, leap = pcall(require, 'leap')
    if not status_ok then
      print '---ERROR: Failed to require leap.nvim ---'
      return
    end

    -- IMPORTANT: Try to remove existing default bindings for 's' and 'S'
    -- We do this because the built-in 's' is active.
    -- We need to provide a right-hand side, even if it's a no-op,
    -- to effectively "clear" it before Leap tries to map.
    -- Or, we can try to directly map over it. Leap's functions should do this.

    -- Option 1: Use Leap's default setup function (this is usually preferred)
    -- This function is supposed to handle unmapping and remapping s, S, x, X.
    -- print '---INFO: Calling leap.add_default_mappings() ---'
    leap.add_default_mappings()

    --[[
    -- Option 2: Manual mapping (Use this if add_default_mappings still fails)
    -- Make sure to comment out leap.add_default_mappings() if you use this.
    print("---INFO: Attempting manual leap mappings ---")
    -- For Normal, Visual, and Operator-pending modes
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap-forward-to)', {noremap = true, silent = true, desc = "Leap forward to"})
    vim.keymap.set({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward-to)', {noremap = true, silent = true, desc = "Leap backward to"})
    vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)', {noremap = true, silent = true, desc = "Leap from window"})
    print("---INFO: Manual leap mappings for s, S, gs should be set ---")
    --]]

    -- For debugging: Check if the <Plug> mappings are created by Leap
    -- After restarting, you can manually check:
    -- :nmap <Plug>(leap-forward-to)
    -- It should show that <Plug>(leap-forward-to) is mapped to some internal Leap Lua function.

    -- Let's try mapping a completely different key to see if Leap's <Plug> targets work at all
    -- print "---INFO: Setting up 'qq' as a test mapping for Leap ---"
    vim.keymap.set({ 'n', 'x', 'o' }, 'qq', '<Plug>(leap-forward-to)', { noremap = true, silent = true, desc = 'TEST Leap forward' })

    -- print '---INFO: leap.nvim config finished ---'
  end,

  -- ALTERNATIVE for lazy.nvim: Using the 'keys' table
  -- If the above 'config' block still gives you trouble with 's',
  -- you can try defining the keys directly in the lazy.nvim spec.
  -- Comment out the 'config' function or at least the mapping parts within it if you use this.
  -- keys = {
  --   {
  --     "s",
  --     function() require("leap").leap { target_windows = {vim.fn.win_getid()} } end,
  --     mode = {"n", "x", "o"},
  --     desc = "Leap forward",
  --   },
  --   {
  --     "S",
  --     function() require("leap").leap { backward = true, target_windows = {vim.fn.win_getid()} } end,
  --     mode = {"n", "x", "o"},
  --     desc = "Leap backward",
  --   },
  --   -- Example for gs
  --   {
  --     "gs",
  --     function() require("leap").leap_from_window() end,
  --     mode = {"n", "x", "o"},
  --     desc = "Leap from window",
  --   }
  -- },
}
