--- dumb stuff I made, from devenv -- NOTE: But it was kind of needed...
os.execute("devenv lsp --print-config  >/tmp/devenv.json 2>/dev/null")
local json = vim.json.decode(io.open("/tmp/devenv.json", "r"):read("a"))

local default_nixd_config = {
  nixd = {
    nixpkgs = {
      expr = "import <nixpkgs> { }",
    },
    options = {
      nixvim = {
        expr = "(builtins.getFlake (toString ./.)).nixvimConfigurations.x86_64-linux.default.options", -- works when you spell correctly...
      },
    },
  },
}
local merged_settings = vim.tbl_deep_extend("force", default_nixd_config, json)

return {
  cmd = { "devenv", "lsp" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = merged_settings,
}
