-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("BufWinEnter_nix_no_inlay_hint", { clear = true }),
--   desc = "Disable inlay_hint for nix files.",
--   pattern = "*.nix",
--   callback = function(ev)
--     vim.lsp.inlay_hint.enable(false) -- ev.buf
--   end,
-- })

local tab_len = 2
-- TEST: instead of vim.bo
vim.o.ts = tab_len
vim.o.sw = tab_len
vim.o.sts = tab_len
