--[[
|==============|
|   AUTOCMDS   |
|==============|
--]]
---@param events vim.api.keyset.events | table<vim.api.keyset.events>
---@param augroupName string
---@param autoOpts vim.api.keyset.create_autocmd
local autocmd = function(events, augroupName, autoOpts)
    local augroup = vim.api.nvim_create_augroup(augroupName, { clear = true })
    autoOpts = vim.tbl_extend("force", { group = augroup }, autoOpts)
    vim.api.nvim_create_autocmd(events, autoOpts)
end

autocmd("BufReadPost", "BufReadPost-restore-cursor", {
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

autocmd("TermEnter", "TermEnter-startinsert", {
    desc = "Insert-mode on TermEnter",
    callback = function()
        vim.cmd("startinsert")
        vim.api.nvim_win_set_config(0, { style = "minimal" })
    end,
})

autocmd("CmdwinEnter", "CmdwinEnter-syntaxHL", {
    desc = "Syntax HL on cmd-win (:)",
    callback = function()
        vim.o.filetype = "lua"
    end,
})
