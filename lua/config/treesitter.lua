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

-- Compat shim for the deprecated nvim-treesitter `master` branch on Nvim 0.11+.
-- Since Nvim 0.11, treesitter directive handlers receive each capture as a list
-- of nodes (TSNode[]); Nvim 0.12 dropped the `{ all = false }` option that the
-- master branch relied on to keep the old single-node format. Its handlers then
-- call get_node_text() on the list and crash with
-- "attempt to call method 'range' (a nil value)" (e.g. markdown code-block
-- injection via render-markdown). Re-register the affected directives so they
-- tolerate both formats. Remove this once nvim-treesitter is migrated to `main`.
do
  -- ensure nvim-treesitter has registered its (broken) handlers first
  pcall(require, "nvim-treesitter.query_predicates")
  local tsq = require("vim.treesitter.query")

  -- Normalize a capture to a single node, accepting both the new list format
  -- and the legacy single-node format.
  local function pick_node(match, id)
    local node = match[id]
    if type(node) == "table" then
      return node[#node]
    end
    return node
  end

  local html_script_type_languages = {
    ["importmap"] = "json",
    ["module"] = "javascript",
    ["application/ecmascript"] = "javascript",
    ["text/ecmascript"] = "javascript",
  }

  local info_string_aliases = {
    ex = "elixir",
    pl = "perl",
    sh = "bash",
    uxn = "uxntal",
    ts = "typescript",
  }

  local function parser_from_info_string(alias)
    local m = vim.filetype.match({ filename = "a." .. alias })
    return m or info_string_aliases[alias] or alias
  end

  tsq.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
    local node = pick_node(match, pred[2])
    if not node then
      return
    end
    local alias = vim.treesitter.get_node_text(node, bufnr):lower()
    metadata["injection.language"] = parser_from_info_string(alias)
  end, { force = true })

  tsq.add_directive("set-lang-from-mimetype!", function(match, _, bufnr, pred, metadata)
    local node = pick_node(match, pred[2])
    if not node then
      return
    end
    local type_attr_value = vim.treesitter.get_node_text(node, bufnr)
    local configured = html_script_type_languages[type_attr_value]
    if configured then
      metadata["injection.language"] = configured
    else
      local parts = vim.split(type_attr_value, "/", {})
      metadata["injection.language"] = parts[#parts]
    end
  end, { force = true })

  tsq.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
    local id = pred[2]
    local node = pick_node(match, id)
    if not node then
      return
    end
    local text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or ""
    if not metadata[id] then
      metadata[id] = {}
    end
    metadata[id].text = string.lower(text)
  end, { force = true })
end
