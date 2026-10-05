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
        "render-markdown" = {
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
              custom = {
                # todo = { raw = "[-]"; rendered = "󰥔 "; highlight = "RenderMarkdownTodo"; scope_highlight.__raw = "nil"; };
                need_input = {
                  raw = "[?]";
                  rendered = " ";
                  highlight = "RenderMarkdownHint";
                  scope_highlight.__raw = "nil";
                };
                urgent = {
                  raw = "[!]";
                  rendered = " ";
                  highlight = "RenderMarkdownError";
                  scope_highlight.__raw = "nil";
                };
                recurring = {
                  raw = "[+]";
                  rendered = " ";
                  highlight = "RenderMarkdownTodo";
                  scope_highlight.__raw = "nil";
                };
                paused = {
                  raw = "[=]";
                  rendered = "󰏤 ";
                  highlight = "RenderMarkdownWarn";
                  scope_highlight.__raw = "nil";
                };
                cancelled = {
                  raw = "[_]";
                  rendered = " ";
                  highlight = "@comment"; # TEST
                  scope_highlight.__raw = "nil";
                };
                # TODO <https://github.com/obsidian-nvim/obsidian.nvim/wiki/Checkbox#create-new>
              };
            };
          };
        };
      };
    };
}
