{ self, inputs, ... }@top:
let
  #XXX: RENAME TO PLUGIN'S NAME
  pluginName = "markdown";
in
{
  flake.homeModules.nixvim_plugins =
    {
      pkgs,
      config,
      lib,
      ...
    }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins = {
        ## [See `render-markdown` docs](https://github.com/MeanderingProgrammer/render-markdown.nvim/tree/main#setup)
        "render-${pluginName}" = {
          enable = true;
          settings = {
            completions = {
              lsp.enabled = true;
              # TEST:
              # blink.enabled = true;
            };
            preset = "obsidian"; # obsidian|lazy|none
            # callout = {}; #TODO: [configure things like: `[!TIP]`](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)
            # link.custom = {}; #TODO: [configure things like: icon for ^https://....](https://github.com/MeanderingProgrammer/render-markdown.nvim/blob/main/doc/render-markdown.txt#L820)
          };
        };

        ## [See `markdown-preview` docs](https://github.com/iamcco/markdown-preview.nvim/#markdownpreview-config)
        "${pluginName}-preview" = {
          enable = true;
          settings = {
            auto_close = 1;
            auto_start = 1;
            browser = config.my.apps.browser.name or "${lib.getExe pkgs.librewolf}";
            echo_preview_url = 1;
            # highlight_css = mkRaw "vim.fn.expand('~/highlight.css')";
            page_title = mkRaw ''
              "MD-preview: " .. vim.fn.pathshorten(os.getenv("PWD"), 2) .. "/''${name}"
            '';
            port = "8080";
            preview_options = {
              disable_filename = 1;
              disable_sync_scroll = 1;
              sync_scroll_type = "middle";
            };
            theme = "dark";
          };
        };
      };
    };
}
