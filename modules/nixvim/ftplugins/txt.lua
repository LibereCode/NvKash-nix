-- -- todo.txt
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   group = vim.api.nvim_create_augroup("BufWinEnter_todo.txt_set_ft", { clear = true }),
--   desc = "Files mathing *todo.txt will set ft=todotxt (which TreeSitter recognize)",
--   pattern = "*todo.txt",
--   callback = function(ev)
--     -- vim.lsp.enable("vale", false)
--   end,
-- })

-- NOTE: see like you cant set ft in ftplugin...
-- vim.o.ft = "todotxt"

--TODO: create a new filetype for todotxt
