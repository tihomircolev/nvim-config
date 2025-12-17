local M = {}

M.toggle_wrap = function()
  if vim.wo.wrap then
    vim.wo.wrap = false
    vim.wo.linebreak = false
    print("Line wrap: OFF")
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
    print("Line wrap: ON")
  end
end

return M
