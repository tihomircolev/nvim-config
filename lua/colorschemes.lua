--- This module will load a random colorscheme on nvim startup process.
local utils = require("utils")

local M = {}

local use_theme = vim.cmd.colorscheme

-- Colorscheme to its directory name mapping, because colorscheme repo name is not necessarily
-- the same as the colorscheme name itself.
M.colorscheme_conf = {
  catppuccin = function()
    require("catppuccin").setup({
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})
-- setup must be called before loading
vim.cmd.colorscheme "catppuccin-macchiato"
    -- use_theme("edge")
  --onedark = function()
  --  -- Lua
  --  require("onedark").setup {
  --    style = "darker",
  --  }
  --  require("onedark").load()
  --end,
  --edge = function()
  --  vim.g.edge_style = "default"
  --  vim.g.edge_enable_italic = 1
  --  vim.g.edge_better_performance = 1

  --  vim.cmd([[colorscheme edge]])
  --end,
  --sonokai = function()
  --  vim.g.sonokai_enable_italic = 1
  --  vim.g.sonokai_better_performance = 1

  --  vim.cmd([[colorscheme sonokai]])
  --end,
  --gruvbox_material = function()
  --  -- foreground option can be material, mix, or original
  --  vim.g.gruvbox_material_foreground = "original"
  --  --background option can be hard, medium, soft
  --  vim.g.gruvbox_material_background = "hard"
  --  vim.g.gruvbox_material_enable_italic = 1
  --  vim.g.gruvbox_material_better_performance = 1

  --  vim.cmd([[colorscheme gruvbox-material]])
  --end,
  --everforest = function()
  --  vim.g.everforest_background = "hard"
  --  vim.g.everforest_enable_italic = 1
  --  vim.g.everforest_better_performance = 1

  --  vim.cmd([[colorscheme everforest]])
  --end,
  --nightfox = function()
  --  vim.cmd([[colorscheme carbonfox]])
  --end,
  --onedarkpro = function()
  --  -- set colorscheme after options
  --  -- onedark_vivid does not enough contrast
  --  vim.cmd("colorscheme onedark_dark")
  --end,
  --material = function()
  --  vim.g.material_style = "darker"
  --  vim.cmd("colorscheme material")
  --end,
  --arctic = function()
  --  vim.cmd("colorscheme arctic")
  --end,
  --kanagawa = function()
  --  vim.cmd("colorscheme kanagawa-dragon")
  --end,
  --modus = function()
  --  vim.cmd([[colorscheme modus]])
  --end,
  --jellybeans = function()
  --  vim.cmd([[colorscheme jellybeans]])
  --end,
  --github = function()
  --  vim.cmd([[colorscheme github_dark_default]])
  --end,
  --e_ink = function()
  --  require("e-ink").setup()
  --  vim.cmd.colorscheme("e-ink")
  --end,
  --ashen = function()
  --  vim.cmd([[colorscheme ashen]])
  --end,
  --melange = function()
  --  vim.cmd([[colorscheme melange]])
  --end,
  --makurai = function()
  --  vim.cmd.colorscheme("makurai_warrior")
  --end,
  --vague = function()
  --  vim.cmd([[colorscheme vague]])
  --end,
  --kanso = function()
  --  vim.cmd([[colorscheme kanso]])
  --end,
  --citruszest = function()
  --  vim.cmd([[colorscheme citruszest]])
  --end,
    -- use_theme("sonokai")
  end,
  gruvbox_material = function()
    -- foreground option can be material, mix, or original
    vim.g.gruvbox_material_foreground = "original"
    --background option can be hard, medium, soft
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_enable_italic = 1
    vim.g.gruvbox_material_better_performance = 1

    use_theme("gruvbox-material")
  end,
  everforest = function()
    vim.g.everforest_background = "hard"
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_better_performance = 1

    use_theme("everforest")
  end,
  nightfox = function()
    use_theme("carbonfox")
  end,
  onedarkpro = function()
    -- set colorscheme after options
    -- onedark_vivid does not enough contrast
    use_theme("onedark_dark")
  end,
  material = function()
    vim.g.material_style = "darker"
    use_theme("material")
  end,
  arctic = function()
    use_theme("arctic")
  end,
  kanagawa = function()
    use_theme("kanagawa-dragon")
  end,
  modus = function()
    use_theme("modus")
  end,
  jellybeans = function()
    use_theme("jellybeans")
  end,
  github = function()
    use_theme("github_dark_default")
  end,
  e_ink = function()
    require("e-ink").setup()
    use_theme("e-ink")
  end,
  ashen = function()
    use_theme("ashen")
  end,
  melange = function()
    use_theme("melange")
  end,
  makurai = function()
    use_theme("makurai_dark")
  end,
  vague = function()
    use_theme("vague")
  end,
  kanso = function()
    use_theme("kanso")
  end,
  citruszest = function()
    use_theme("citruszest")
  end,
}

--- Use a random colorscheme from the pre-defined list of colorschemes.
M.rand_colorscheme = function()
  local colorscheme = utils.rand_element(vim.tbl_keys(M.colorscheme_conf))

  -- Load the colorscheme and its settings
  -- M.colorscheme_conf[colorscheme]()
  M.colorscheme_conf["catppuccin"]()
end

return M
