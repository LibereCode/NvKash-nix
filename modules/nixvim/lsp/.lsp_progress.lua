--[[ ========================
              LspProgress in statusbar
          -- ======================== ]]

---@param events string|string[]
---@param augroupName string
---@param autoOpts vim.api.keyset.create_autocmd
local function lsp_autocmd(events, augroupName, opts)
  local group = vim.api.nvim_create_augroup(augroupName, { clear = true })
  local autoOpts = vim.tbl_extend("force", { group = group }, opts)
  vim.api.nvim_create_autocmd(events, autoOpts)
end
lsp_autocmd({ "LspProgress" }, "LspProgress-nvim_echo", { -- best
  desc = [[
              LspProgress autocmd.
              Declared in: {file}`nixvim/nix/lsp.nix`.
            ]],
  callback = function(ev)
    local val = ev.data.params.value
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client then
      local message = val.message
      if message then
        message = "  " .. message
      else
        message = " ✔ DONE"
      end
      vim.api.nvim_echo({ { message } }, false, {
        id = "lsp." .. ev.data.client_id,
        kind = "progress",
        source = "vim.lsp",
        title = "[" .. client.name .. "] " .. val.title,
        status = val.kind ~= "end" and "running" or "success",
        percent = val.percentage,
      })
    end
  end,
})
