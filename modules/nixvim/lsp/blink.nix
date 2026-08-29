{ self, inputs, ... }@top:
let
  plugin_name = "blink-cmp";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      config,
      lib,
      pkgs,
      ...
    }@a:
    let
      inherit (lib.nixvim.utils) listToUnkeyedAttrs;
      inherit (lib.nixvim) mkRaw;
      #INFO: listToUnkeyedAttrs ["a" "b"] == {__unkeyed-1 = "a"; __unkeyed-2 = "b";}
    in
    {
      #INFO: <https://nix-community.github.io/nixvim/plugins/blink-cmp/settings/index.html>
      plugins = {
        ${plugin_name} = {
          enable = true;
          setupLspCapabilities = true;

          # <https://nix-community.github.io/nixvim/plugins/blink-cmp/settings/index.html>
          settings = {
            appearance = {
              nerd_font_variant = "normal";
              # use_nvim_cmp_as_default = true;
              kind_icons = {
                Class = "󱡠";
                Color = "󰏘";
                Constant = "󰏿";
                Constructor = "󰒓";
                Enum = "󰦨";
                EnumMember = "󰦨";
                Event = "󱐋";
                Field = "󰜢";
                File = "󰈔";
                Folder = "󰉋";
                Function = "󰊕";
                Interface = "󱡠";
                Keyword = "󰻾";
                Method = "󰊕";
                Module = "󰅩";
                Operator = "󰪚";
                Property = "󰖷";
                Reference = "󰬲";
                Snippet = "󱄽";
                Struct = "󱡠";
                Text = "󰉿";
                TypeParameter = "󰬛";
                Unit = "󰪚";
                Value = "󰦨";
                Variable = "󰆦";
              };
            };

            completion = {
              accept = {
                auto_brackets = {
                  enabled = true;
                  # semantic_token_resolution = { enabled = false; };
                };
              };
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 345;
              };
              ghost_text = {
                enabled = true;
                show_without_selection = true;
                # show_with_menu = false;
              };
              # keyword = {}; # regex rules
              list.selection = {
                auto_insert = false;
                preselect = true;
              };
              menu = {
                border = "none";
                direction_priority = mkRaw ''
                  function() -- :h blink-cmp-recipes --> ghost_text
                    local blink = require("blink.cmp")
                    local ctx = blink.get_context()
                    local item = blink.get_selected_item()
                    if ctx == nil or item == nil then return { "s", "n" } end

                    local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
                    local is_multi_line = item_text:find("\n") ~= nil
                    if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
                      vim.g.blink_cmp_upwards_ctx_id = ctx.id
                      return { "n", "s" }
                    end
                    return { "s", "n" }
                  end
                '';
                draw = {
                  treesitter = [ "lsp" ];
                  columns = listToUnkeyedAttrs [
                    (
                      listToUnkeyedAttrs [
                        "kind_icon"
                        "label"
                        "label_description"
                      ]
                      // {
                        gap = 1;
                      }
                    )
                    (
                      listToUnkeyedAttrs [
                        "kind"
                        "source_name"
                      ]
                      // {
                        gap = 1;
                      }
                    )
                  ];
                };
                # order = {}; # WARN Not yet implemented
              };
              trigger = {
                # <https://nix-community.github.io/nixvim/plugins/blink-cmp/settings/completion/trigger.html>
                # prefetch_on_insert = true; # WARN Just do not
                show_on_insert_on_trigger_character = true;
                show_on_trigger_character = true;
              };
            };

            # fuzzy = { };

            keymap = {
              #TEST:
              #NOTE: using many of the default keybinds (just want to have it here)
              preset = "none";

              "<C-e>" = [
                "show"
                "cancel"
                "fallback"
              ];
              "<C-CR>" = [
                "accept_and_enter"
                "fallback"
              ];
              "<C-y>" = [
                "select_and_accept"
                "show"
                "fallback"
              ];
              # "<C-l>" = [
              #   "select_and_accept"
              #   "fallback"
              # ];
              #TEST: Figure out what to do with <C-l>
              "<C-;>" = [
                "select_and_accept"
                "fallback"
              ];
              "<C-u>" = [
                "scroll_documentation_up"
                "scroll_signature_up"
                "fallback"
              ];
              "<C-d>" = [
                "scroll_documentation_down"
                "scroll_signature_down"
                "fallback"
              ];
              "<C-b>" = [
                "scroll_signature_up"
                "scroll_documentation_up"
                "fallback"
              ];
              "<C-f>" = [
                "scroll_signature_down"
                "scroll_documentation_down"
                "fallback"
              ];
              "<C-n>" = [
                "select_next"
                "snippet_forward"
                "show" # TEST
                "fallback"
              ];
              "<C-p>" = [
                "select_prev"
                "snippet_backward"
                "show" # TEST
                "fallback"
              ];
              "<C-space>" = [
                "show"
                "show_documentation"
                "hide_documentation"
                # "fallback" # ?
              ];
              "<C-k>" = [
                "show_signature"
                "hide_signature"
                "fallback"
              ];
              # <C-j> = See ../lsp.nix
              "<Down>" = [
                "select_next"
                "fallback"
              ];
              "<Up>" = [
                "select_prev"
                "fallback"
              ];
              "<S-Tab>" = [
                "snippet_backward"
                "fallback"
              ];
              "<Tab>" = [
                "snippet_forward"
                "fallback"
              ];

            };

            signature = {
              enabled = true;
            };

            # snippets = {};

            cmdline = {
              sources = mkRaw ''
                function()
                  local type = vim.fn.getcmdtype()
                  -- Search forward and backward
                  if type == '/' or type == '?' then return { 'buffer' } end
                  -- Commands
                  if type == ':' then return { 'cmdline' } end
                  return {}
                end
              '';
              completion = {
                menu.auto_show = mkRaw ''
                  function(ctx)
                    local cmd_type = vim.fn.getcmdtype()
                    return cmd_type == ":" or cmd_type == "@"
                  end
                '';
                # ghost_text.enabled = true; # XXX Does not work for cmdline?
                list.selection = {
                  auto_insert = true; # false;
                  preselect = false;
                };
              };
              keymap = {
                preset = "inherit"; # "cmdline"|"none"|"inherit"
                "<Tab>" = [
                  "show"
                  "select_and_accept"
                  "fallback"
                ];
                "<C-n>" = [
                  "select_next"
                  "fallback"
                ];
                "<C-p>" = [
                  "select_prev"
                  "fallback"
                ];
                "<C-space>" = [
                  "show"
                  "hide"
                  "fallback"
                ];
                "<C-Cr>" = [
                  "select_accept_and_enter"
                  "fallback"
                ];
              };
            };

            snippets.preset = "luasnip";

            sources = {
              default = [
                "lsp"
                "path"
                "snippets"
                "buffer"
                "ripgrep"
              ];
              providers = {
                buffer = {
                  score_offset = -99;
                };
                lsp = {
                  fallbacks = [ ];
                };
                ripgrep = {
                  async = true;
                  module = "blink-ripgrep";
                  name = "Ripgrep";
                  score_offset = -72;
                  opts = {
                    prefix_min_len = 3;
                    context_size = 5;
                    max_filesize = "1M";
                    project_root_marker = ".git";
                    project_root_fallback = true;
                    search_casing = "--ignore-case";
                    additional_rg_options = { };
                    fallback_to_regex_highlighting = true;
                    ignore_paths = { };
                    additional_paths = { };
                    debug = false;
                  };
                };
              };
            };
          };
        };

        blink-indent = {
          enable = true;
          # See: <https://github.com/Saghen/blink.indent/#options>
          settings = {
            # mappings = {};
            static = {
              enabled = false;
            };
            scope = {
              char = "¦";
              highlights = mkRaw ''{ "BlinkIndentOrange" }''; # "BlinkIndentScope"
            };
            underline = {
              enabled = true;
              hightlights = mkRaw ''{ "BlinkIndentOrange" }'';
            };
          };
          luaConfig.post = /* lua */ ''
            local indent = require('blink.indent')
            vim.keymap.set('n', '<leader>ui', function()
              indent.enable(not indent.is_enabled())
            end, { desc = 'Toggle indent guides' })
          '';
        };

        blink-pairs = {
          enable = false; # Too early in development. [See nvim-autoindent](./nvim-autopairs)

          # see: <https://github.com/Saghen/blink.pairs#installation>
          settings = {
          };
        };

        blink-ripgrep = {
          enable = true;
          # configure trough `plugins.blink-cmp.settings.sources.providers = {};`
        };

        #TODO: Either one of:
        # blink-cmp-dictionary = {};
        # blink-cmp-words = {};
      };
    };
}
