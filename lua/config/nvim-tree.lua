local keymap = vim.keymap
local nvim_tree = require("nvim-tree")

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  
  -- Copy/paste keymaps
  vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Preview'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  
  -- PLACE THE SNIPPET HERE (Inside the function so it can see 'opts')
  vim.keymap.set('n', 's', function()
  local node = api.tree.get_node()
  if node and node.absolute_path then
    vim.ui.open(node.absolute_path)
  end
end, opts('System Open'))
end

nvim_tree.setup {
  on_attach = my_on_attach,
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_netrw = true,
  hijack_cursor = false,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = false,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}

-- Guard against E565 from the async git-status redraw racing a textlock
-- (e.g. yanking via a targets.vim text object). If draw() lands during
-- textlock, retry on the next safe tick instead of throwing.
do
  local ok, Renderer = pcall(require, "nvim-tree.renderer")
  if ok and type(Renderer) == "table" and type(Renderer.draw) == "function" then
    local orig_draw = Renderer.draw
    local function safe_draw(self)
      local success, err = pcall(orig_draw, self)
      if not success and type(err) == "string" and err:find("E565") then
        vim.schedule(function()
          safe_draw(self)
        end)
      end
    end
    Renderer.draw = safe_draw
  end
end

keymap.set("n", "<space>s", require("nvim-tree.api").tree.toggle, {
  silent = true,
  desc = "toggle nvim-tree",
})
