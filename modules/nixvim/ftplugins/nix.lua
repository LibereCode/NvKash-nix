vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("BufWinEnter_nix_no_inlay_hint", { clear = true }),
    desc = "Disable inlay_hint for nix files.",
    pattern = "*.nix",
    callback = function(ev)
        vim.lsp.inlay_hint.enable(false) -- ev.buf
    end,
})
