--[[
|==============|
|   MAPPINGS   |
|==============|
--]]
---@alias mapmode
---|"" - N _ _ V S O _ _
---|"n" - N _ _ _ _ _ _ _
---|"!" - _ I C _ _ _ _ _
---|"i" - _ I _ _ _ _ _ _
---|"c" - _ _ C _ _ _ _ _
---|"v" - _ _ _ V S _ _ _
---|"x" - _ _ _ V _ _ _ _
---|"s" - _ _ _ _ S _ _ _
---|"o" - _ _ _ _ _ O _ _
---|"t" - _ _ _ _ _ _ T _
---|"l" - _ I C _ _ _ _ L
---|"ia" Insert  Abbr
---|"ca" Command Abbr
---|"!a" Ins+Cmd Abbr

---@param key string -- _|string[]_ `key-arr[]` not implemented yet in nvim 0.12
---@param cmd string|function Either a **vim-cmd** _string_ OR a **lua-function**
---@param opts? vim.keymap.set.Opts optional _table_ of **options**
---@param mode? mapmode|mapmode[] See **:h nvim_set_keymap()**
local function map(key, cmd, opts, mode)
  mode = mode or ""
  opts = opts or {}
  vim.keymap.set(mode, key, cmd, opts)
end

--[[
     Cmd
--]]
-- map("<leader>e", function()
--     vim.cmd("Ex")
--     map("<leader>e", ":Rex<CR>")
-- end, { desc = "Ex" })

map("<ESC>", ":nohl<CR>:<C-c>", { silent = true, remap = true }, "n")
map("<C-;>", function()
  if vim.fn.getcmdwintype() == ":" then
    vim.cmd.q()
  else
    vim.api.nvim_input("q:") -- see :h 'cedit'
  end
end, { desc = "toggle [:]cmd-like window" })
map("<C-;>", function()
  vim.api.nvim_input(vim.o.cedit)
end, { desc = "enter [:]cmd-window" }, "c")
map("<M-;>", ":lua ", { desc = ":lua" }, "n")
map("<C-a>", "<HOME>", { silent = true }, "c")
map("<C-b>", "<S-Left>", {}, "c")
map("<C-f>", "<S-Right>", {}, "c")

-- map("<C-s>", ":write<CR>", { remap = true }, "n") -- see **conform-nvim** mapping
map("<C-q>", ":quit<CR>", {}, "n")
map("<leader>qr", ":restart<CR>", {}, "n")
map("<leader>qs", ':w <BAR> so | echo "written & sauced"<CR>', { desc = "save & sauce" }) -- figure out why I can't sauce this file
map("<leader>qw", ":wa<CR>", { desc = "[w]rite all" })
map("<leader>qq", ":qa<CR>", { desc = "[q]uit all" })
map("<C-A-s>", ':write<CR> :source<CR> :echo("written & sauced")<CR>', { desc = "Save&sauce" }) -- NOTE: 'macros' (multiple cmd chained) are possible like this

--[[
    Ui toggles
--]]
map("<leader>uw", "<CMD>set wrap!<CR>", { desc = "toggles [w]rap" })
map("<leader>ul", "<CMD>set nu!<CR>", { desc = "toggle [l]ine-nr" })
map("<leader>ur", "<CMD>set rnu!<CR>", { desc = "toggle [r]elative-line-nr" })
map("<leader>uL", "<CMD>set cul!<CR>", { desc = "toggle cursor-[L]ine" })
map("<leader>uc", function()
  vim.opt_local.cursorcolumn = not vim.o.cursorcolumn
end, { desc = "toggle [c]ursorColumn" })
map("<leader>uC", function()
  vim.opt_local.cursorline = not vim.o.cursorline
  vim.opt_local.cursorcolumn = not vim.o.cursorcolumn
end, { desc = "toggle [C]ursor{Line+Column}" })

--[[
    Buffer
--]]

map("<leader>bb", ":e #<CR>", { desc = "switch to other", noremap = true, silent = true }, "n")
map("<leader>bl", ":buffers<CR>", { desc = "[l]list buffers", noremap = true, silent = true }, "n")
map("<leader>bn", ":enew<CR>", { desc = "new buffer", noremap = true, silent = true }, "n")

-- -- Moved to bufferline
-- map("H", ":bp<CR>", { desc = "prev buf", noremap = true, silent = true }, "n")
-- map("L", ":bn<CR>", { desc = "next buf", noremap = true, silent = true }, "n")
-- local bufdel = ":enew|bd # |bn| bd #<CR>"
-- map("<leader>bd", bufdel, { desc = "[d]delete", noremap = true, silent = true }, "n")
-- map("<leader>x", bufdel, { desc = "delete[x]buffer", noremap = true, silent = true }, "n")

--[[
    Window
--]]

---If furthest nvim window, switch tmux-pane instead
---@param vim_key "h"|"j"|"k"|"l" vim-key used (ie: direction)
---@param tmux_key "-L"|"-D"|"-U"|"-R" tmux equivalent for same direction
local function tmux_move(vim_key, tmux_key)
  local is_furthest = vim.fn.winnr(vim_key) == vim.fn.winnr()
  if is_furthest then
    os.execute("tmux select-pane " .. tmux_key .. " 2>/dev/null")
  else
    vim.cmd.wincmd(vim_key)
  end
end

-- map("<C-h>", "<C-w>h", {}, "n")
-- map("<C-j>", "<C-w>j", {}, "n")
-- map("<C-k>", "<C-w>k", {}, "n")
-- map("<C-l>", "<C-w>l", {}, "n")
for k, v in pairs({ h = "-L", j = "-D", k = "-U", l = "-R" }) do
  map("<C-" .. k .. ">", function()
    tmux_move(k, v)
  end, {}, "n")

  map("<C-M-" .. k .. ">", "<C-w>" .. k:upper(), {}, "n")
end
-- map("<C-h>", function()
--     tmux_move("h", "-L")
-- end, {}, "n")
-- map("<C-j>", function()
--     tmux_move("j", "-D")
-- end, {}, "n")
-- map("<C-k>", function()
--     tmux_move("k", "-U")
-- end, {}, "n")
-- map("<C-l>", function()
--     tmux_move("l", "-R")
-- end, {}, "n")

-- map("<C-M-h>", "<C-w>H", {}, "n")
-- map("<C-M-j>", "<C-w>J", {}, "n")
-- map("<C-M-k>", "<C-w>K", {}, "n")
-- map("<C-M-l>", "<C-w>L", {}, "n")

map("<M-S-->", function()
  vim.cmd.wincmd("2-")
end, { desc = "[-] win-height" })
map("<M-S-=>", function()
  vim.cmd("wincmd 2+")
end, { desc = "[+] win-height" })
map("<M-S-,>", function()
  vim.api.nvim_win_set_width(0, vim.api.nvim_win_get_width(0) - 2)
end, { desc = "width less [<]" })
map("<M-S-.>", "<C-w>2>", { desc = "width more [>]" })

map("<C-TAB>", "<C-w>w", { desc = "next window" }, "n")
map("<C-S-TAB>", "<C-w>W", { desc = "prev window" }, "n")
--?TODO: <XX-TAB> for vim-tabs instead?

map("<leader>|", ":vsplit<CR>", { desc = "vert[|]split" }, "n")
map("<leader>_", ":split<CR>", { desc = "hor[_]split" }, "n")

--?TODO:
-- map("<leader>T", function()
--     local getConf = vim.api.nvim_win_get_config(0)
--     if getConf.relative ~= "" then
--         vim.api.nvim_win_set_config(0, { split = "above", win = vim.fn.win_getid(1) })
--     else
--         vim.api.nvim_win_set_config(0, {
--             relative = "editor",
--             width = math.floor(vim.o.columns * 0.8),
--             height = math.floor(vim.o.lines * 0.8),
--             col = math.floor(vim.o.columns * 0.1),
--             row = math.floor(vim.o.lines * 0.1),
--         })
--     end
-- end, { desc = "[T]uuggle float" }, "n")

--[[
    Tabs
--]]
map("<leader><TAB>l", ":tabs<CR>", { desc = "tab list" }, "n")
map("<leader><TAB><TAB>", ":tabnew<CR>", { desc = "new" }, "n")
map("<leader><TAB>d", ":tabclose<CR>", { desc = "delete" }, "n")
map("<leader><TAB>p", ":tabprev<CR>", { desc = "prev" }, "n")
map("<leader><TAB>n", ":tabnext<CR>", { desc = "next" }, "n")
map("<leader><TAB>t", "<C-W>T", { desc = "window->newtab" }, "n")

--[[
    QoL
--]]
map("<C-c>", "gcc", { remap = true }, "n")
map("<C-c>", "gc", { remap = true }, "x")

map("j", "gj", { silent = true }, { "n", "x" }) --function() vim.api.nvim_input("gj") end
map("k", "gk", { silent = true }, { "n", "x" })

map("U", "<C-r>", { desc = "[U]UN-undo (=redo)" }, "n") -- default "U" is shit

map("<M-i>", "^", { desc = "Left<-most" }, "n") -- remap = true
map("<M-a>", "$", { desc = "Right->most" }, "n") -- remap = true

map("<M-f>", "za", { desc = "[f]fold" }, "n")

map("<leader>m", ":mes<CR>", { desc = "[m]messages", silent = true }, "n")

-- Selection-mode
map("<C-v>", "<C-o>P", { desc = "Paste in S-mode", remap = true }, "s")
map("<C-c>", "<C-o>y", { desc = "Copy in S-mode", remap = true }, "s")
map("<C-x>", "<C-o>d", { desc = "Cut in S-mode", remap = true }, "s")

-- Visual-mode
map("<leader>y", '"yy', { desc = '[y]yank 2 "y' }, "x")
map("<leader>p", '"yp', { desc = '[p]paste from "y' }, "x")
map("<C-y>", '"yy', { desc = '[y]yank 2 "y' }, "x")
map("<C-p>", '"yp', { desc = '[p]paste from "y' }, "x")
map("<leader>d", '"yd', { desc = '[d]delete 2 "y' }, "x")
map("<leader>p", '"yp', { desc = '[p]paste from "y' }, "n")

map("<leader>P", '"_dd<ESC>P', { desc = "delete->[p]aste, no yank" }, { "x", "n" })

-- Insert-mode
map("<C-v>", "<ESC>pa", { desc = "I-mode paste", remap = true }, "i") --  "<C-o>p"
map("#", " <C-h>#", { desc = "see :smartindent" }, "i") -- why isnt this deafult?

map("<M-h>", "<Left>", { desc = "<-", silent = false }, { "i", "s", "c" })
map("<M-j>", "<Down>", { desc = "v", silent = false }, { "i", "s", "c" })
map("<M-k>", "<Up>", { desc = "^", silent = false }, { "i", "s", "c" })
map("<M-l>", "<Right>", { desc = "->", silent = false }, { "i", "s", "c" })

--[[
    Abbreviations
--]]
---(mode) { "ia" == "Ins abbr", "ca" == "Cmd abbr", "!a" == "Both abbr" }
map("<C-l>", "<C-]>", { desc = "trigger abbrev" }, "!")

map("l", "lua", { desc = "l -> lua" }, "ca")
map("v", "vim.", { desc = "v -> vim" }, "ca")
map("nvim", "vim.api.nvim_", { desc = "nvim -> vim.api.nvim_" }, "ca")
map("vp", "vim.print()<left>", { desc = "vp -> vim.print(|)" }, "ca")

--[[
    Terminal
--]]
-- map({ "<C-ESC>", "<ESC><ESC>" }, "<C-\\><C-n>", { remap = true }, "t") -- available in nvim 0.13
map("<C-ESC>", "<C-\\><C-n>", { remap = true }, "t")
map("<ESC><ESC>", "<C-\\><C-n>", { remap = true }, "t")

-- map("<leader>tv", ":vert te<CR>", { desc = "[v]vert terminal" }, "n")
-- map("<leader>th", ":hor te<CR>", { desc = "[h]hor terminal" }, "n")
-- map("<leader>tT", function()
--     vim.cmd.terminal()
-- end, { desc = "[T]Terminal buffer" }, "n")

--[[
    toggle map
--]]
-- ---@alias mode string|string[]
-- ---@alias key string
-- ---@alias cmd fun()
-- ---@alias opts vim.keymap.set.Opts
-- ---@alias func_opts [mode, key, cmd, opts]
-- ---Curesed way of making a toggleable mapping (by recursively re-declare it)
-- ---@param now func_opts
-- ---@param after func_opts
-- local function toggleMap(now, after)
--   local mode, key, cmd, opts = now[1], now[2], now[3], now[4]
--   vim.keymap.set(mode, key, function()
--     cmd()
--     toggleMap(after, now)
--   end, opts)
-- end
-- -- fml
-- toggleMap({
--   "n",
--   "<leader>ud",
--   function()
--     vim.diagnostic.enable(false, { bufnr = 0 })
--   end,
--   { desc = "toggle off diagnostics filly" },
-- }, {
--   "n",
--   "<leader>ud",
--   function()
--     vim.diagnostic.enable(true, { bufnr = 0 })
--   end,
--   { desc = "toggle on [D]Diagnostic FULLY" },
-- })
