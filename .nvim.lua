--- dumb stuff I made, from devenv -- NOTE: But it was kind of needed...
os.execute("devenv lsp --print-config  >/tmp/devenv.json 2>/dev/null")
local json = vim.json.decode(io.open("/tmp/devenv.json", "r"):read("a"))

local default_nixd_config = {
  nixd = {
    nixpkgs = {
      expr = "import <nixpkgs> { }",
    },
    options = {
      nixos = {
        expr = "(builtins.getFlake (toString ./.)).nixvimConfigurations.x86_64-linux.defualt.options",
      },
    },
  },
}
local merged_settings = vim.tbl_deep_extend("force", default_nixd_config, json)

-- This is what I think they mean? <https://devenv.sh/lsp/#editor-setup>
vim.lsp.config("nixd", {
  cmd = { "devenv", "lsp" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = merged_settings,
})
vim.lsp.enable("nixd")
