{
  ...
}:
let
  plugin_name = "aerial";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      lib,
      config,
      ...
    }:
    {
      #TODO: Integrations <https://github.com/stevearc/aerial.nvim/#third-party-integrations>:
      # - [ ] [Telescope](https://github.com/stevearc/aerial.nvim/#telescope)
      # - [ ] [LuaLine](https://github.com/stevearc/aerial.nvim/#lualine)

      plugins = {
        ${plugin_name} = {
          enable = true;
          # INFO <https://github.com/stevearc/aerial.nvim/#options>
          settings = {
            attach_mode = "global";
            backends = [
              "treesitter"
              "lsp"
              "markdown"
              "asciidoc"
              "man"
            ];
            disable_max_lines = 5000;
            highlight_on_hover = true;
            ignore = {
              filetypes = [
                "gomod"
              ];
            };
            # keymaps = {};
            filter_kind = false; # <- false == show all
            # filter_kind = [
            #   ## Default:
            #   "Class"
            #   "Constructor"
            #   "Enum"
            #   "Function"
            #   "Interface"
            #   "Module"
            #   "Method"
            #   "Struct"
            #   ## Added:
            #   "Constant"
            #   "Event"
            #   "File"
            #   "Namespace"
            #   "Object"
            #   "Package"
            #   "Variable"
            # ];
          };
          luaConfig.post = ''
            do
          ''
          + lib.optionalString config.plugins.telescope.enable /* lua */ ''
            require("telescope").load_extension("aerial")
            require("telescope").setup({
              extensions = {
                aerial = {
                  -- Set the width of the first two columns (the second
                  -- is relevant only when show_columns is set to 'both')
                  col1_width = 4,
                  col2_width = 30,
                  -- How to format the symbols
                  format_symbol = function(symbol_path, filetype)
                    if filetype == "json" or filetype == "yaml" then
                      return table.concat(symbol_path, ".")
                    else
                      return symbol_path[#symbol_path]
                    end
                  end,
                  -- Available modes: symbols, lines, both
                  show_columns = "both",
                },
              },
            })
          ''
          +
            # lua
            ''
                vim.keymap.set("n","<leader>a", "<cmd>AerialToggle<CR>", { desc = "toggle [a]aerial" })
                vim.keymap.set("n","<leader>A", "<cmd>AerialNavToggle<CR>", { desc = "toggle [A]Aerial Nav" })
              end
            '';
        };
      };
    };
}
