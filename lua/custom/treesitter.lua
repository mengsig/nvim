local M = {}

M.languages = {
  'bash',
  'c',
  'cpp',
  'css',
  'dockerfile',
  'go',
  'gomod',
  'gosum',
  'html',
  'javascript',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'scss',
  'sql',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
  'zig',
}

M.filetypes = {
  bash = true,
  c = true,
  cpp = true,
  css = true,
  dockerfile = true,
  go = true,
  gomod = true,
  gosum = true,
  html = true,
  javascript = true,
  javascriptreact = true,
  json = true,
  jsonc = true,
  lua = true,
  make = true,
  markdown = true,
  python = true,
  rust = true,
  scss = true,
  sql = true,
  toml = true,
  typescript = true,
  typescriptreact = true,
  vim = true,
  vimdoc = true,
  xml = true,
  yaml = true,
  zig = true,
}

function M.install()
  return require('nvim-treesitter').install(M.languages)
end

return M
