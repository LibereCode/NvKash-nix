{ self, inputs, ... }@top:
let
  plugin_name = "lualine";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkraw;
      inherit (lib.nixvim.utils) listToUnkeyedAttrs;
    in
    {
      # see: <https://nix-community.github.io/nixvim/plugins/lualine/index.html>
      plugins = {
        ${plugin_name} = {
          enable = true;

          settings = {
            options = {
              icons_enabled = true;
              theme = "auto";
              # component_separators = { left = "", right = "" };
              # section_separators = { left = "", right = "" };
              component_separators = {
                left = "|";
                right = "|";
              };
              section_separators = {
                left = "";
                right = "";
              };

              disabled_filetypes =
                listToUnkeyedAttrs [
                  "startify"
                  "alpha"
                  "telescope"
                  # "oil"
                  # "toggleterm"
                  # "trouble"
                ]
                // {
                  statusline = [
                    "dap-repl"
                  ];
                  winbar = [
                    "aerial"
                    "dap-repl"
                    "neotest-summary"
                  ];
                };
              # ignore_focus = { }; #??

              always_divide_middle = true;
              always_show_tabline = true;
              globalstatus = false;

              refresh = {
                ## Update if auto if no event
                statusline = 1000;
                # tabline = 100;
                # winbar = 1000;
                ## speed
                # refresh_time = 16; # ~60fps
                refresh_time = 10; # ?~35fps
                events = [
                  ## events
                  "WinEnter"
                  "BufEnter"
                  "BufWritePost"
                  "SessionLoadPost"
                  "FileChangedShellPost"
                  "VimResized"
                  "Filetype"
                  "CursorMoved"
                  "CursorMovedI"
                  "ModeChanged"
                ];
              };

            };
            /*
              EXAMPLES:
              =========
              "branch"
              -> {'branch', icon = {'', align='right', color={fg='green'}}}

              ... color = { fg = '#ffaa88', bg = 'grey', gui='italic,bold' },
              # can be #123456, "red", "style1,style2", 256?,
              # hl-group (ie: "Commment") ; manually do  hl-group:
              # fg.__raw = ''"#" .. tostring(vim.print(vim.api.nvim_get_hl_by_name("Normal", "fg").foreground))'';
              # function(section) return { fg = vim.bo.modified and '#aa3355' or '#33aa88' } end,
            */
            sections = {
              lualine_a = [
                "mode"
              ];
              lualine_b = [
                "filename"

                # "branch"
              ];
              lualine_c = [
                "branch"
                "diff"
              ];
              lualine_x = [
                "diagnostics"
                # "lsp_status"
                {
                  __unkeyed-1.__raw = ''
                    function()
                        local msg = ""
                        local buf_ft = vim.bo[0].filetype
                        local clients = vim.lsp.get_clients({ bufnr = 0 })
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end
                  '';
                  # color = {
                  #   # fg = "#ffffff"
                  #   fg.__raw = ''"#" .. tostring(vim.print(vim.api.nvim_get_hl_by_name("Normal", "fg").foreground))'';
                  # };
                  icon = ""; # 
                }
                "filetype"
                # "encoding"
                # "fileformat"
              ];
              lualine_y = [
                # -- "selectioncount"
                # -- "progress"
                {
                  __unkeyed-1.__raw = ''
                    function()
                      -- Copyright (c) 2020-2021 hoob3rt
                      -- MIT license, see lualine LICENSE for more details.
                      local mode = vim.fn.mode(true)
                      local line, col = vim.fn.line, vim.fn.col
                      local line_delta = math.abs(line 'v' - vim.fn.line '.') + 1
                      local col_delta = math.abs(col 'v' - vim.fn.col '.') + 1
                      -- if mode:match("[vVi]") or mode:match("n[oi]") then -- no = normal operator (like d or c)
                      -- local col = '%c→' .. tostring(vim.fn.col('$') - 1) .. "|"
                      -- local line = "|" .. '%l↓%L'
                      -- local left, middle, right = col, " ", line
                      if mode:match '' then
                        return string.format('%02dx%02d', col_delta, line_delta)
                      elseif mode:match 'V' or line_delta ~= 1 then
                        -- middle = line_delta
                        return string.format("__x%02d", line_delta)
                      elseif mode:match 'v' then
                        -- middle = col_delta -- string.format('%d,%d', line_delta, col_delta)
                        return string.format("%02dx__", col_delta)
                      else
                        return " " .. os.date "%R"
                      end
                    end,
                  '';
                }

                # {
                #   __unkeyed-1 = "aerial";
                #   colored = true;
                #   cond = {
                #     __raw = ''
                #       function()
                #         local buf_size_limit = 1024 * 1024
                #         if vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0)) > buf_size_limit then
                #           return false
                #         end
                #
                #         return true
                #       end
                #     '';
                #   };
                #   dense = false;
                #   dense_sep = ".";
                #   depth = {
                #     __raw = "nil";
                #   };
                #   sep = " ) ";
                # }
              ];
              lualine_z = [
                # -- 'location',
                # -- function() return 'B) c:C=%c:' .. vim.fn.strwidth(vim.fn.getline '.') end, --  (being n+1) is really easy fixed
                # -- function() return ' ' .. os.date '%R' end, -- clock
                # {
                #   __unkeyed-1.__raw = ''
                #     function() return '%c→' .. vim.fn.col '$' - 1 end,
                #   ''; # -- NOTE: `col` is way faster, and only drawback
                # }
                {
                  __unkeyed-1.__raw = ''
                    function()
                      local mode = vim.fn.mode(true)
                      local line, col = vim.fn.line, vim.fn.col
                      local line_delta = math.abs(line 'v' - vim.fn.line '.') + 1
                      local col_delta = math.abs(col 'v' - vim.fn.col '.') + 1

                      local col = '%c→' .. tostring(vim.fn.col('$') - 1)
                      local line = '%l↓%L'
                      return col .. " " .. line
                    end,
                  '';
                  # function()
                  #   local col = '%c→' .. tostring(vim.fn.col('$') - 1)
                  #   local line = '%l↓%L'
                  #   return col .. " " .. line
                  # end,
                }
                # {
                #   __unkeyed-1 = "location";
                # }
              ];
            };

            # tabline = {
            #   lualine_a = [
            #     {
            #       __unkeyed-1 = "buffers";
            #       symbols = {
            #         alternate_file = "";
            #       };
            #     }
            #   ];
            #   lualine_z = [
            #     "tabs"
            #   ];
            # };

            # winbar = {
            #   lualine_x = [
            #     {
            #       __unkeyed-1 = "filename";
            #       newfile_status = true;
            #       path = 3;
            #       shorting_target = 150; }
            #   ];
            # };

            # Source: <https://github.com/nvim-lualine/lualine.nvim/tree/master/lua/lualine/extensions>
            extensions = [
              # "fzf"
              # "lazy"
              "man"
              # "mason"
              # "neo-tree"
              "nvim-dap-ui"
              "oil"
              "quickfix"
              "symbols-outline"
              "toggleterm"
              "trouble"
            ];

          }; # TODO: <https://nix-community.github.io/nixvim/plugins/lualine/settings/index.html>
        };
      };
    };
}
