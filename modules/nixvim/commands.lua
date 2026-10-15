local command = vim.api.nvim_create_user_command
local loglvl = vim.log.levels

command("EditLineCol", function(opts)
  local file, ---@type string?
      line, ---@type string?
      col ---@type string?
    =
      opts.args:match("^(.*):(%d+):(%d+)$")
  if not file or not line or not col then
    vim.notify("Expected `file:line:column`", loglvl.ERROR)
    return
  end

  vim.cmd("edit " .. vim.fn.fnameescape(file))
  vim.api.nvim_win_set_cursor(0, { tonumber(line), math.max(tonumber(col) - 1, 0) })
end, { nargs = 1, desc = "Open/edit file:line:column", complete = "file" })
