--[[
      Diagnostics
--]]
do
  local map = vim.keymap.set
  ---Mappings for diagnostics
  ---@param lhs string key after leader: `"<leader>" .. **key**`
  ---@param rhs fun()|string regular old keymap rhs: lua function or vim_cmd_string
  ---@param opts vim.keymap.set.Opts the will be put in a table of opts
  local function diagMap(lhs, rhs, opts)
    vim.keymap.set("n", "<leader>" .. lhs, rhs, opts)
  end

  diagMap("do", function()
    vim.diagnostic.setloclist()
  end, { desc = "l[o]clist" })

  diagMap("dc", function()
    vim.diagnostic.open_float({ scope = "b" })
  end, { desc = "[c]ursor diagnostic" })

  diagMap("dd", function()
    vim.diagnostic.open_float()
  end, { desc = "line [d]diagnostic" })

  diagMap("db", function()
    vim.diagnostic.open_float({ scope = "b" })
  end, { desc = "[b]uffer diagnostic" })

  diagMap("dl", function()
    vim.cmd("tabnew " .. vim.fn.stdpath("log"))
  end, { desc = "open [l]logs" })

  diagMap("dt", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, { desc = "[t]toggle diagnostic (FULL global)" })

  diagMap("ud", function()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config })
  end, { desc = "[d]diagnostic virtual_lines ()" })

  diagMap("uD", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 })
  end, { desc = "[D]Diagnostic (FULL local)" })

  diagMap("uh", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = "toggle inlay[h]hints" })
end
