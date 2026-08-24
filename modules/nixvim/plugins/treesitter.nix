{ self, inputs, ... }@top:
let
  plugin_name = "treesitter";
in
{
  flake.nixvimModules.${plugin_name} =
    {
      pkgs,
      lib,
      config,
      ...
    }@a:
    let
      inherit (lib.nixvim) mkraw;
    in
    {
      plugins = {
        # https://nix-community.github.io/nixvim/plugins/treesitter/index.html#treesitter
        ${plugin_name} = {
          enable = true;
          highlight.enable = true;
          folding.enable = true;
          indent = {
            enable = true;
            # disable = [
            #   ## disable treesitter folding for these ft:
            #   "nix" # it works kinda shit for nix
            # ];
            ## Either a list of a lua-function.
            ## See: <https://nix-community.github.io/nixvim/plugins/treesitter/indent.html#pluginstreesitterindentdisable>
            disable.__raw = ''
              ---Values recieved from nixvim? Via tree-sitter?
              ---@param lang string tree-sitter language name
              ---@param buf integer `bufnr` of target
              ---@param ft string `filetype` of target
              ---@return boolean Disable when returning `true`
              function(lang, buf, ft)
                if lang == "nix" then
                  vim.bo[buf].cindent = true
                  vim.cmd([[setlocal cinwords+=let]]) -- why? sucks ass
                  -- vim.bo[buf].cinkeys = ""                  return true
                end
              end
            '';
          };

          #NOTE: by default all grammar is installed
          # grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          #   awk
          #   bash
          #   c c_sharp clojure cmake comment commonlisp cpp css
          #   diff dockerfile
          #   editorconfig
          #   fish
          #   git_config git_rebase gitattributes gitcommit gitignore go gpg
          #   html hyprlang
          #   ini
          #   java javadoc javascript jq jsdoc json json5
          #   kdl kitty
          #   latex lua luadoc
          #   make markdown markdown_inline meson
          #   nix
          #   nu
          #   powershell printf python
          #   regex rst rust
          #   scheme ssh_config sway
          #   # tmux # removed in unstable
          #   todotxt toml typescript
          #   vim vimdoc
          #   xcompose xml xresources
          #   yaml yuck
          #   # zathurarc # removed in unstable
          #   zig ziggy ziggy_schema zsh
          # ];
        };

        treesitter-context = {
          enable = true;
          settings = {
            multiwindow = true;
            max_lines = "25%";
            multiline_threshold = 1; # TEST:
            # separator = "-";
          };
        };
      };
    };
}
