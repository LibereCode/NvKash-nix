{ ... }:
let
  module_name = "markdown";
in
{
  flake.nixvimModules.${module_name} =
    {
      config,
      ...
    }:
    let
      #: [Presets](https://github.com/OXY2DEV/markview.nvim/wiki/Presets)
      presets = module: { __raw = ''require("markview.presets").${module}''; };
    in
    {
      plugins = {
        #: [See `markview` docs](https://github.com/OXY2DEV/markview.nvim#-table-of-contents)
        markview = {
          #: WARN No color for headings D:
          enable = true && !config.plugins.render-markdown.enable;
          settings = {
            preview = {
              enable = true;
              enable_hybrid_mode = true;
              icon_provider = "devicons"; # "mini";
              # modes = ["n" "no" "c"];
              hybrid_modes = [
                "n"
                "no"
              ];
              # linewise_hybrid_mode = true; # default (false) is scope-based instead (better).
            };

            #: [Markdown](https://github.com/OXY2DEV/markview.nvim/wiki/Markdown)
            #: See also `presets`
            markdown = {
              headings = presets "headings.glow";
              # horizontal_rules = presets "horizontal_rules.dashed";
              tables = presets "tables.none"; # TEST
              # block_quotes = presets "obsidian";
            };

            #: [Markdown Inline](https://github.com/OXY2DEV/markview.nvim/wiki/Markdown-inline#checkboxes)
            markdown_inline = {
              checkboxes = {
                "+" = {
                  text = "";
                  hl = "MarkviewCheckboxPending";
                };
                "-" = {
                  text = "󰥔";
                  hl = "MarkviewCheckboxProgress";
                  scope_hl = "";
                };
                "_" = {
                  text = ""; # "󰍶";
                  hl = "@comment";
                  scope_hl = "MarkviewCheckboxStriked";
                };
                "!" = {
                  text = "󰀦";
                  hl = "ErrorMsg";
                };
                "=" = {
                  text = "󰏤";
                  hl = "WarningMsg";
                };
              };
            };

          };
          luaConfig.post = ''
            ---{{ text/markview.nix luaConfig.post
            do
              vim.keymap.set("n", "<localleader>s", "<CMD>Markview splitToggle<CR>", { desc = "markview: splitToggle" })

              ---[Extras](https://github.com/OXY2DEV/markview.nvim/wiki/Extras#-code-block-editor)
              -- ---TEST [Checkbox toggle](https://github.com/OXY2DEV/markview.nvim/wiki/Extras#-checkbox-toggle)
              -- require("markview.extras.checkboxes").setup({
              --     default = "X",
              --     remove_style = "disable",
              --     states = {
              --       { --[[...]] },
              --       --[[...,]]
              --     }
              -- })
              ---[Code block editor](https://github.com/OXY2DEV/markview.nvim/wiki/Extras#-code-block-editor)
              require("markview.extras.editor").setup();
              vim.keymap.set("n", "<localleader>e", "<CMD>Editor edit<CR>", { desc = "markview: code block edit" })
            end
            ---text/markview.nix luaConfig.post }}
          '';
        };
      };
    };
}
