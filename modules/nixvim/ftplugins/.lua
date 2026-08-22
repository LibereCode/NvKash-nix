-- todo.txt -- TEST:
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("BufEnter_todo.txt_set_ft", { clear = true }),
  desc = "Files mathing *todo.txt will set ft=todotxt (which TreeSitter recognize)",
  pattern = "*todo.txt",
  callback = function(ev)
    -- vim.lsp.enable("vale", false)

    local bo = vim.bo[ev.buf]
    bo.ft = "todotxt"
  end,
})

--TODO: create a new filetype for todotxt
