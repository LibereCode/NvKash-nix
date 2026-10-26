{ ... }:
let
  module_name = "markdown";
in
{
  flake.nixvimModules.${module_name} =
    {
      ...
    }:
    {
      plugins = {
        ## [See `render-markdown` docs](https://github.com/MeanderingProgrammer/render-markdown.nvim/tree/main#setup)
        render-markdown = {
          enable = true; # true; # TEST
          settings = {
            completions = {
              lsp.enabled = true;
              # TEST:
              blink.enabled = true;
            };
            preset = "obsidian"; # obsidian|lazy|none
            # callout = {}; #TODO: [configure things like: `[!TIP]`](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)
            # link.custom = {}; #TODO: [configure things like: icon for ^https://....](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)

            checkbox = {
              checked.scope_highlight = "@comment"; # TEST
              custom = {
                # todo = { raw = "[-]"; rendered = "󰥔 "; highlight = "RenderMarkdownTodo"; scope_highlight.__raw = "nil"; };
                todo.scope_highlight = "RenderMarkdownTodo";
                need_input = {
                  raw = "[?]";
                  rendered = " ";
                  highlight = "RenderMarkdownHint";
                  scope_highlight = "RenderMarkdownHint"; # .__raw = "nil"; # TEST
                };
                urgent = {
                  raw = "[!]";
                  rendered = " ";
                  highlight = "RenderMarkdownError";
                  scope_highlight = "RenderMarkdownError"; # .__raw = "nil"; # TEST
                };
                recurring = {
                  raw = "[+]";
                  rendered = " ";
                  highlight = "RenderMarkdownTodo";
                  scope_highlight = "RenderMarkdownTodo"; # .__raw = "nil"; # TEST
                };
                paused = {
                  raw = "[=]";
                  rendered = "󰏤 ";
                  highlight = "RenderMarkdownWarn";
                  scope_highlight = "RenderMarkdownWarn"; # .__raw = "nil"; # TEST
                };
                trashed # cancelled
                  = {
                    raw = "[_]";
                    rendered = " ";
                    highlight = "@comment";
                    scope_highlight = "RenderMarkdownTrashed";
                  };
                strikethrough = {
                  raw = "[~]";
                  rendered = " ";
                  highlight = "@comment";
                  scope_highlight = "RenderMarkdownTrashed"; # "@markup.strikethrough";
                };
                # TODO <https://github.com/obsidian-nvim/obsidian.nvim/wiki/Checkbox#create-new>
              };
            };
          };
          luaConfig.pre = ''
            local hl_comment = vim.api.nvim_get_hl(0, {}).Comment
            vim.api.nvim_set_hl(0, "RenderMarkdownTrashed", { fg = hl_comment.fg, strikethrough = true })
          '';
        };
      };
    };
}
