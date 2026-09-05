{
  ...
}:
let
  pluginName = "orgmode";
in
{
  flake.nixvimModules.${pluginName} =
    {
      ...
    }:
    let
      org_dir = "~/Notes/org";
    in
    {
      plugins = {
        ## INFO GUIDE <https://nvim-orgmode.github.io/tutorial>
        orgmode = {
          enable = true;

          ## DOCS <https://nvim-orgmode.github.io/configuration>
          settings = {
            org_agenda_files = org_dir + "/**/*";
            org_default_notes_file = org_dir + "/refile.org";
          };

          luaConfig.post = ''
            -- [orgmode.nvim](https://nvim-orgmode.github.io/)
            do
              vim.lsp.enable("org")
            end
          '';
        };

        ## See <https://nvim-orgmode.github.io/plugins#blinkcmp>
        blink-cmp.settings = {
          sources = {
            # per_filetype = {
            #   org = [ "orgmode" ];
            # };
            providers = {
              orgmode = {
                name = "Orgmode";
                module = "orgmode.org.autocompletion.blink";
                fallbacks = [ "buffer" ];
              };
            };
          };
        };
      };
    };
}
