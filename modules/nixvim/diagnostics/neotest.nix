{
  ...
}:
let
  pluginName = "neotest";
in
{
  flake.nixvimModules.${pluginName} =
    {
      ...
    }:
    {
      plugins = {
        neotest = {
          enable = true;
          adapters = {
            bash.enable = true;
            ctest.enable = true; # c
            plenary.enable = true; # plenary.nvim ?
            python.enable = true;
            rust.enable = true;
            zig.enable = true;
          };
          settings = {
            output = {
              enabled = true;
              open_on_run = true;
            };
            output_panel = {
              enabled = true;
              open = "botright split | resize 15";
            };
            quickfix = {
              enabled = true;
            };
            status = {
              virtual_text = true; # TEST
            };
            summary = {
              # mappings = {
              # <https://nix-community.github.io/nixvim/plugins/neotest/settings/summary.html#pluginsneotestsettingssummarymappings>
              # };
            };
          };

          luaConfig.post = ''
            ---neotest.nvim ; See <https://github.com/nvim-neotest/neotest#usage>
            do
              local nt = require("neotest")
              local map = vim.keymap.set
              map("n", "<leader>tr", nt.run.run, {desc = "[NeoTest] [r]run nearest"})
              map("n", "<leader>ts", nt.run.stop, {desc = "[NeoTest] [s]stop nearest"})
              map("n", "<leader>ta", nt.run.attach, {desc = "[NeoTest] [a]attach nearest"})
              map("n", "<leader>tw", function() nt.watch.toggle(vim.fn.expand("%")) end, {desc = "[NeoTest] [w]atch file"})
              map("n", "<leader>ts", "<cmd>Neotest summary<CR>", {desc = "[NeoTest] [s]summary"})
              map("n", "<leader>td", function() nt.run.run({strategy = "dap"}) end, {desc = "[NeoTest] [d]ap"})
            end
          '';
        };
      };
    };
}
