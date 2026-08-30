{ self, inputs, ... }@top:
let
  pluginName = "trouble";
  #NOTE: replaced with neotest & outline
in
{
  # flake.nixvimModules.plugins =
  #   {
  #     pkgs,
  #     config,
  #     lib,
  #     ...
  #   }@a:
  #   {
  #     plugins = {
  #       ${pluginName} = {
  #         enable = true;
  #
  #         settings = {
  #           # auto_close = false; # when 0 diagnostics
  #           # auto_jump = false; # when there's only 1
  #           # auto_preview = true;
  #           # auto_refresh = false; # ???
  #           # focus = false;
  #           # follow = true;
  #           # indent_guides = true;
  #           # max_items = 200;
  #           # multiline = true;
  #           # open_no_results = false;
  #           # pinned = false;
  #           # restore = true;
  #           # warn_no_results = true;
  #
  #           # icons = {}; # many
  #
  #           # Many defaults: <https://nix-community.github.io/nixvim/plugins/trouble/settings.html#pluginstroublesettingskeys>
  #           # keys = { };
  #
  #           # Also alot <https://nix-community.github.io/nixvim/plugins/trouble/settings.html#pluginstroublesettingsmodes>
  #           # modes = {};
  #
  #           # preview = {}; window opts for preview
  #
  #           # win = {}; # window opts for results window
  #         };
  #         luaConfig.post = ''
  #           do
  #             local map = vim.keymap.set
  #
  #             local a = require("trouble.async")
  #             map('n', '<leader>T', function()
  #               require("trouble").toggle({
  #                 {
  #                   modes = {
  #                     preview_float = {
  #                       mode = "diagnostics",
  #                       preview = {
  #                         type = "float",
  #                         relative = "editor",
  #                         border = "rounded",
  #                         title = "Preview",
  #                         title_pos = "center",
  #                         position = { 0, -2 },
  #                         size = { width = 0.3, height = 0.3 },
  #                         zindex = 200,
  #                       },
  #                     },
  #                   },
  #                 }
  #               })
  #             end, { desc = 'Trouble: Buffer Diagnostics' })
  #
  #             map('n', '<leader>dx', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Trouble: Buffer Diagnostics' })
  #             map('n', '<leader>dX', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Trouble: Diagnostics' })
  #             map('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Trouble: [s]ymbols' })
  #             map('n', '<leader>cS', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { desc = 'Trouble: [l]sp' }) -- 'LSP Definitions / references / ... (Trouble)'
  #             map('n', '<leader>dO', function()
  #               vim.diagnostic.setloclist { open = false }
  #               vim.cmd [[Trouble loclist toggle]]
  #             end, { desc = 'Trouble: L[O]Clist' })
  #             map('n', '<leader>dq', '<cmd>Trouble qflist toggle<cr>', { desc = 'Trouble: [q]uickfix' })
  #           end
  #         '';
  #       };
  #     };
  #   };
}
