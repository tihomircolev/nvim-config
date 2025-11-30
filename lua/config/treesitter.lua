require("nvim-treesitter.configs").setup {
  ensure_installed = { "python", "rust", "cpp", "lua", "vim", "json", "toml", "powershell"},
  ignore_install = {},
  highlight = {
    enable = true,
    disable = { "help" },
    additional_vim_regex_highlighting = false,
  },
  auto_install = true,
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ps1", "psm1", "psd1" },
  callback = function(args)
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        pcall(vim.treesitter.start, args.buf, 'powershell')
      end
    end, 100)
  end,
})
