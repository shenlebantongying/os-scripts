local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    { "ibhagwan/fzf-lua" },
    {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      }
    }
})

vim.o.background = "light"
vim.cmd([[colorscheme gruvbox]])

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

if vim.g.neovide then 
    vim.o.guifont = "Intel One Mono:h10"
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_animation_length = 0.05   
end

