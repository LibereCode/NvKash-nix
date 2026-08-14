{
  self,
  inputs,
  ...
}:
{
  flake.nixvimModules.theme =
    { pkgs, ... }@args:
    {
      colorscheme = "kanagawa-dragon";

      colorschemes.kanagawa = {
        enable = true;
        # callSetup = true;

        settings = {
          theme = "dragon";
          background = {
            dark = "dragon";
            light = "lotus";
          };

          compile = true;

          dimInactive = true;
          undercurl = true;
          transparent = false;

          commentStyle = {
            italic = false;
          };
          functionStyle = {
            bold = true;
          };
          keywordStyle = { };
          statementStyle = { };
          typeStyle = {
            italic = true;
          };

          terminalColors = true;
          colors = {
            palette = { };
            theme = {
              # wave = {}; lotus = {}; dragon = {};
              all = {
                ui = {
                  bg_gutter = "#1D1C19";
                };
              };
            };
          };

          overrides =
            # lua
            ''
              function(colors)
                local theme = colors.theme

                local mkDiagCol = function(color)
                  local c = require("kanagawa.lib.color")
                  return {
                    fg = color,
                    bg = c(color)
                      :blend(theme.ui.bg, 0.95)
                      :to_hex()
                  }
                end

                return {
                  String = { italic = true },

                  -- dark completion-popup
                  Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },
                  PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                  PmenuSbar = { bg = theme.ui.bg_m1 },
                  -- PmenuThumb = { bg = theme.ui.bg_p2 },
                  PmenuKind = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                  PmenuExtra = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },

                  -- diagnostics
                  DiagnosticVirtualTextHint = mkDiagCol(theme.diag.hint),
                  DiagnosticVirtualTextInfo = mkDiagCol(theme.diag.info),
                  DiagnosticVirtualTextWarn = mkDiagCol(theme.diag.warning),
                  DiagnosticVirtualTextError = mkDiagCol(theme.diag.error),

                  -- telescope
                  -- TODO:
                }
              end
            '';
        };
      };
    };
}
