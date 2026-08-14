--[[
|=============|
|   OPTIONS   |
|=============|
--]]
-- NOTE: see ../nix/options.nix
local o = vim.opt

--[[
    ==========
    * format
    ==========
--]]

local tabLen = 4
o.tabstop = tabLen
o.softtabstop = tabLen
o.shiftwidth = tabLen

o.swapfile = true
-- o.directory = "."
-- o.backup = true
-- o.backupdir = (lua "vim.fn.stdpath('data') .. '/bakkupp//'")
o.undofile = true
-- o.undodir = (lua "vim.fn.stdpath('state') .. '/exampleUndoDir//'")
o.undolevels = 1723
o.confirm = true

--[[
    ==========
    *  look
    ==========
--]]

o.number = true
o.relativenumber = true

o.cursorline = true
o.colorcolumn = { "80", "-1" }
-- o.textwidth = 100

o.wrap = false
o.showmatch = true
o.showmode = false

o.list = true
o.listchars = {
    eol = " ", --  ␤ 󰌑 
    tab = "⇥ ", -- ↣ ↪ ⇢ ⇛ ⇒ ⇨ ⇥ 󰌒 »
    multispace = " ", -- string.rep(" ", (vim.o.ts - 1)) .. "␣", -- mark "shiftwidth" tabs

    trail = "·", -- ␣ 󱁐 · ␠
    lead = " ",
    nbsp = "⍽",
    extends = "󰶻", --  →⃨
    precedes = "󰶺", --  ←
}

o.fillchars = {
    foldopen = "",
    foldclose = "", -- "",
    fold = "·", -- · " "
    foldsep = "", -- " ",
    diff = "╱",
    eob = " ",
}

o.breakindent = true

o.ruler = false
o.signcolumn = "yes"

o.termguicolors = true

o.winborder = "·,¯,·,¦,·,ˍ,·,¦" -- ¦·.ˍߺ˙¯‾ ".,-,.,¦,˙,-,˙,¦"

--[[
  ==========
  *  feel
  ==========
--]]
o.ignorecase = true
o.smartcase = true

o.inccommand = "split"
o.virtualedit = "block"

o.scrolloff = 10
o.sidescrolloff = 10

o.foldlevel = 99
o.foldmethod = "indent"
o.foldtext = ""

o.smarttab = true
o.smartindent = true -- TODO: cindent for nix files
o.expandtab = true

o.mouse = "nvc"
o.selectmode = "key" -- "mouse"

o.updatetime = 250
o.timeoutlen = 222

o.splitright = true
o.splitbelow = true

o.splitkeep = "cursor"
o.lazyredraw = true

o.wildmode = { longest = "full" }
o.wildoptions = { "fuzzy", "pum", "tagfile" }

o.whichwrap:append("<>[]hl")
o.shortmess:append("as")

--[[
    globals
--]]
local g = vim.g

g.have_nerd_font = true

-- TEST: disable default providers

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.markdown_recommended_style = 0

--[[
    special
--]]

require("vim._core.ui2").enable({
    msg = { -- Options related to the message module.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds, triggers and IDs to a target.
        ---Table keys are are matched as a Lua pattern to the message ID. 'default'
        ---mapping applies to any omitted kind: { default = 'cmd', progress = 'msg' }.
        targets = "cmd",
        cmd = { -- Options related to messages in the cmdline window.
            -- Maximum height (rows if >=1, or % of 'lines' if <1) of messages expanded
            -- beyond 'cmdheight'; 0.999 for full height.
            height = 0.5,
        },
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
            height = 0.999, -- Maximum height.
        },
    },
})
