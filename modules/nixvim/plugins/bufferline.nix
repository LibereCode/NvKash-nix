{ self, inputs, ... }@top:
let
  plugin_name = "bufferline";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, ... }@a:
    {
      # see: <https://nix-community.github.io/nixvim/plugins/bufferline/index.html>
      plugins = {
        ${plugin_name} = {
          enable = true;

          # <https://nix-community.github.io/nixvim/plugins/bufferline/settings/index.html>
          settings = {

            # highlights = {
            #   buffer_selected.bg = "#363a4f";
            #   fill.bg = "#1e2030";
            #   numbers_selected.bg = "#363a4f";
            #   separator.fg = "#1e2030";
            #   separator_selected = {
            #     bg = "#363a4f";
            #     fg = "#1e2030";
            #   };
            #   separator_visible.fg = "#1e2030";
            #   tab_selected.bg = "#363a4f";
            # };

            options = {
              always_show_bufferline = true;
              buffer_close_icon = "󰅖";
              close_icon = "";
              close_command.__raw = ''
                function(bufnr)
                  local old_bufnr = vim.fn.bufnr()
                  bufnr = bufnr or old_bufnr

                  -- this + nvim_buf_delete: mimics bdelete!
                  vim.bo[bufnr].buflisted = false

                  if bufnr == old_bufnr then
                    require("bufferline").cycle(1)
                    -- If only 1 buf was left: create an empty buffer
                    if vim.fn.bufnr() == old_bufnr then
                      vim.cmd("enew")
                    end
                  end

                  vim.api.nvim_buf_delete(old_bufnr, { unload = true })
                end
              '';

              # custom_filter.__raw = ''
              #   function(buf_number, buf_numbers)
              #     -- filter out filetypes you don't want to see
              #     if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
              #         return true
              #     end
              #     -- filter out by buffer name
              #     if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
              #         return true
              #     end
              #     -- filter out based on arbitrary rules
              #     -- e.g. filter out vim wiki buffer from tabline in your work repo
              #     if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
              #         return true end -- filter out by it's index number in list (don't show first buffer)
              #     if buf_numbers[1] ~= buf_number then
              #         return true
              #     end
              #   end
              # '';

              diagnostics = "nvim_lsp";
              diagnostics_indicator.__raw = ''
                function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end
              '';

              #   ''
              #   function(count, level, diagnostics_dict, context)
              #     local s = ""
              #     for e, n in pairs(diagnostics_dict) do
              #       local sym = e == "error" and " "
              #         or (e == "warning" and " " or "" )
              #       if(sym ~= "") then
              #         s = s .. " " .. n .. sym
              #       end
              #     end
              #     return s
              #   end
              # '';

              enforce_regular_tabs = false;
              get_element_icon.__raw = ''
                function(element)
                  -- element consists of {filetype: string, path: string, extension: string, directory: string}
                  -- This can be used to change how bufferline fetches the icon
                  -- for an element e.g. a buffer or a tab.
                  -- e.g.
                  local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
                  return icon, hl
                  -- -- or
                  -- local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}}
                  -- return custom_map[element.filetype]
                end
              '';

              groups = {
                items = [
                  {
                    highlight = {
                      fg = "#a6da95";
                      sp = "#494d64";
                      underline = true;
                    };
                    matcher.__raw = ''
                      function(buf)
                        return buf.name:match('%test') or buf.name:match('%.spec')
                      end
                    '';
                    name = "Tests";
                    priority = 2;
                  }
                  {
                    auto_close = false;
                    highlight = {
                      fg = "#ffffff";
                      sp = "#494d64";
                      undercurl = true;
                    };
                    matcher.__raw = ''
                      function(buf)
                        return buf.name:match('%.md') or buf.name:match('%.txt')
                      end
                    '';
                    name = "Docs";
                  }
                ];
                options.toggle_hidden_on_enter = true;
              };

              indicator = {
                icon = "▎";
                style = "icon";
              };
              left_trunc_marker = "";
              max_name_length = 18;
              max_prefix_length = 15;
              mode = "buffers";
              modified_icon = "●";
              numbers.__raw = ''
                function(opts)
                  return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
                end
              '';
              offsets = [
                {
                  filetype = "neo-tree";
                  highlight = "Directory";
                  text = "File Explorer";
                  text_align = "center";
                }
              ];
              persist_buffer_sort = true;
              right_trunc_marker = "";
              separator_style = [
                "|"
                "|"
              ];
              show_buffer_close_icons = true;
              show_buffer_icons = true;
              show_close_icon = true;
              show_tab_indicators = true;
              sort_by.__raw = ''
                function(buffer_a, buffer_b)
                    local modified_a = vim.fn.getftime(buffer_a.path)
                    local modified_b = vim.fn.getftime(buffer_b.path)
                    return modified_a > modified_b
                end
              '';
              tab_size = 18;
            };
          };

          luaConfig.post = ''
            do
              local bl = require("bufferline")
              local map = vim.keymap.set
              local function blmap(lhs, rhs, opts, mode)
                mode = mode or ""
                opts = vim.tbl_extend("force", { desc = "TODO: bufferline-key: " .. lhs , silent = true }, opts)
                map(mode, lhs, rhs, opts)
              end

              blmap("H", function() bl.cycle(-1) end, { desc = "cycle prev buf" })
              blmap("L", function() bl.cycle(1) end, { desc = "cycle next buf" })

              blmap("<M-S-H>", function() bl.move(-1) end, { desc = "move buf pos left" })
              blmap("<M-S-L>", function() bl.move(1) end, { desc = "move buf pos right" })

              for i=1, 9, 1 do
                local i_str = tostring(i)
                blmap("<leader>" .. i_str, function() bl.go_to(i) end, { desc = "goto buf " .. i_str})
              end
              blmap("<leader>0", function() bl.go_to(-1) end, { desc = "goto last buf"})

              blmap("<leader>bd", function() bl.unpin_and_close() end, { desc = "buf unpin_and_close" })
              blmap("<leader>x", function() bl.unpin_and_close() end, { desc = "buf unpin_and_close" })
            end
          '';
        };

      };
    };
}
