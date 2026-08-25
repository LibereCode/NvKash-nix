{ self, inputs, ... }@top:
let
  plugin_name = "conform-nvim";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      mkLua = lib.nixvim.mkRaw;
      inherit (lib.nixvim.utils) listToUnkeyedAttrs;
    in
    {
      plugins = {
        ${plugin_name} = {
          enable = true;

          autoInstall = {
            enable = true;
          };

          settings = {
            log_level = "warn";
            notify_on_error = false;
            notify_no_formatters = false;

            # format_on_save =
            #   # lua
            #   ''
            #     function(bufnr)
            #       local va = vim.api
            #       local bufname = va.nvim_buf_get_name(bufnr)
            #
            #       -- from nixvim -> conform-nvim -> settings example
            #       -- start
            #       if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return nil end
            #       if slow_format_filetypes and slow_format_filetypes[vim.bo[bufnr].filetype] then return nil end
            #       local function on_format(err)
            #         if err and err:match("timeout$") then
            #           slow_format_filetypes[vim.bo[bufnr].filetype] = true
            #         end
            #       end
            #
            #       local disable_filetypes = { c = true, cpp = true }
            #       if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
            #       -- end
            #
            #       -- INFO Disable formatter if 2nd line reads: "# fmt:off" (where "#" is commentstring)
            #       local line2 = va.nvim_buf_get_lines(bufnr, 1, 2, false)[1] or ""
            #       if line2:match(vim.o.commentstring:gsub('%%s', 'fmt:off')) then return nil end
            #
            #       return { timeout_ms = 345, lsp_format = "fallback", }, on_format
            #     end
            #   '';

            default_format_opts = {
              timeout_ms = 500;
              lsp_format = "fallback";
              stop_after_first = true;
            };

            formatters_by_ft = {
              nix = [ "nixfmt" ]; # "alejandra" "nixfmt"
              lua = [ "stylua" ];

              c = [ "clang-format" ];
              cpp = [ "clang-format" ];
              go = [ "gofmt" ];
              rust = [ "rustfmt" ];

              fish = [ "fish_indent" ];
              python = [
                "ruff_format"
                "ruff_fix"
                "ruff_organize_imports"
              ];

              css = [ "prettierd" ];
              markdown = [ "prettierd" ];
              yaml = [ "prettierd" ];
              json = [ "prettierd" ];
              jsonc = [ "prettierd" ];

              html = [ "superhtml" ];
              kdl = [ "kdlfmt" ];
              xml = [ "xmlformatter" ];

              ## For all filetypes
              # "*" = [ "foobar" ];

              ## For filestypes with no other formatters:
              "_" = [ "trim_whitespace" ];

            };

            formatters = {
              prettierd = {
                "inherit" = true;
                prepend_args = mkLua /* lua */ ''{ "--trailing-comma=es5", "--no-semi", "--single-quote" }'';
              };
            };
          };
          luaConfig.post = # lua
            ''
              local conform = require("conform")
              vim.keymap.set({"n", "v"}, "<C-f>", function() conform.format({async = true}) end, { desc = "[f]format buffer" })
              vim.keymap.set({"n"}, "<C-s>", function()
                conform.format({async = false})
                vim.cmd.write()
              end, {desc = "[f]format buffer"})
            '';
        };
      };
    };
}
