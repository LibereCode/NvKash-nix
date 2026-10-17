--[[
|==============|
|   AUTOCMDS   |
|==============|
--]]
---@param events vim.api.keyset.events |vim.api.keyset.events[]
---@param augroupName string
---@param autoOpts vim.api.keyset.create_autocmd
local autocmd = function(events, augroupName, autoOpts)
  local augroup = vim.api.nvim_create_augroup(augroupName, { clear = true })
  autoOpts = vim.tbl_extend("force", { group = augroup }, autoOpts)
  vim.api.nvim_create_autocmd(events, autoOpts)
end

autocmd({ "BufReadPost" }, "BufReadPost-restore-cursor", {
  desc = "Restore cursor position",
  callback = function()
    local line = vim.fn.line("'\"")
    if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

autocmd({ "WinEnter" }, "BufWinEnter_ToggleTerm_start_insert", {
  pattern = { "term://*" },
  desc = "Enter insert-mode when focusing terminal-buffers.",
  callback = function(ev)
    vim.cmd.startinsert()
    -- vim.api.nvim_win_set_config(0, { style = "minimal" }) -- 0 == vim.api.nvim_get_current_win()
  end,
})

autocmd({ "CmdwinEnter" }, "CmdwinEnter-syntaxHL", {
  desc = "Syntax HL on cmd-win (:)",
  callback = function()
    vim.o.filetype = "lua"
  end,
})

---{{ NOTE set filetypes

local function autoSetFt(ft, pattern)
  autocmd({ "BufEnter" }, "BufEnter_set_ft_" .. ft, {
    desc = "Set ft=" .. ft .. " when matching patterns: " .. table.concat(pattern, ", "),
    pattern = pattern,
    callback = function(ev)
      vim.bo[ev.buf].ft = ft
    end,
  })
end

-- autocmd("BufEnter", "BufEnter_todotxt_set_ft", {
--   desc = "Set ft=todotxt when entering that kind of file...",
--   pattern = { "*.todo.txt", "todo.txt" },
--   callback = function(ev)
--     vim.bo[ev.buf].ft = "todotxt"
--   end,
-- })
autoSetFt("todotxt", { "*.todo.txt", "todo.txt", "*.done.txt", "done.txt", "*.2do", "*.2do.txt", "2do.txt", "*.done" })
-- autoSetFt("2do", { "*.2do", "*.2do.txt", "2do.txt" }) -- TODO replace ft: todotxt -> 2do
autoSetFt("dosini", { "*config", "config" })
autoSetFt("log", { "*.log" })

---NOTE filetype autocmds }}

autocmd({ "BufWinEnter" }, "BufWinEnter_todotxt_.nvim", {
  desc = "Filetype config for todotxt.",
  pattern = "*todo.txt",
  callback = function(ev)
    local map = vim.keymap.set
    map({ "n" }, "<localleader>x", function()
      local line = vim.api.nvim_get_current_line()
      if line:sub(1, 1) == "x" then
        vim.api.nvim_set_current_line(line:sub(3))
      else
        vim.api.nvim_set_current_line("x " .. line)
      end
    end, { desc = "toggle done", buf = ev.buf })
  end,
})

---To REALLY SHOW when I am recording a macro
do
  local state = {
    buf = -1,
    win = -1,
  }

  autocmd({ "RecordingEnter" }, "RecordingEnter_notify", {
    desc = "Notify when starting to record a macro.",
    callback = function(ev)
      -- vim.o.cmdheight = 2 --- Weird

      local msg, level =
        "RECORDING macro on registry: <" .. tostring(vim.fn.reg_recording()) .. ">", vim.log.levels.WARN
      vim.notify(msg, level)

      local ok, fidget = pcall(require, "fidget")
      if ok then
        fidget.notify(msg, level)
      end

      state.buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, { msg })
      state.win = vim.api.nvim_open_win(state.buf, false, {
        relative = "win",
        row = vim.api.nvim_win_get_height(0) - 4,
        col = (vim.api.nvim_win_get_width(0) - 2 - msg:len()) / 2,
        width = msg:len(),
        height = 1,
        style = "minimal",
        border = "solid",
      })

      local hl_warn = vim.api.nvim_get_hl(0, { name = "WarningMsg" })
      ---@diagnostic disable-next-line: param-type-mismatch vim.api.keyset.{ get_hl_info == highlight }
      vim.api.nvim_set_hl(1, "Normal", hl_warn)
      vim.api.nvim_win_set_hl_ns(state.win, 1)
    end,
  })

  autocmd({ "RecordingLeave" }, "RecordingLeave_notify", {
    desc = "Notify when stopping macro-recording.",
    callback = function(ev)
      local msg, level = "stopped recording macro on registry: <" .. vim.fn.reg_recording() .. ">", vim.log.levels.INFO
      vim.notify(msg, level)

      local ok, fidget = pcall(require, "fidget")
      if ok then
        fidget.notify(msg, level)
      end

      vim.bo[state.buf].buflisted = false
      vim.api.nvim_buf_delete(state.buf, { unload = true })

      -- vim.o.cmdheight = 0 --- weird
    end,
  })
end
