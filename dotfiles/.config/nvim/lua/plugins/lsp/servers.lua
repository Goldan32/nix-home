return {
  bashls = {},
  shellcheck = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  clangd = {
    cmd = {
      'clangd',
      '--header-insert=never',
      '-j4',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--rename-file-limit=0',
      '--background-index',
      '--background-index-priority=normal',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  },
  svelte = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
}
