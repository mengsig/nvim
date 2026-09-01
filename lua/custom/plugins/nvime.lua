return {
  dir = '~/Projects/nvime/',
  build = 'npm --prefix agent install && npm --prefix agent run build',
  name = 'nvime',
  opts = {
    keymaps = { enabled = true },
  },
}
