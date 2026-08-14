{ self, inputs, ... }@top:
{
  # flake.homeModules.nixvim_plug_treesitter =
  flake.homeModules.nixvim_plugins =
    { pkgs, ... }@a:
    {
      plugins = {
        # https://nix-community.github.io/nixvim/plugins/treesitter/index.html#treesitter
        treesitter = {
          enable = true;
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;

          # grammarPackages = with args.config.programs.nixvim.plugins.treesitter.package; [
          grammarPackages = with a.config.plugins.treesitter.package.builtGrammars; [
            awk
            bash
            c
            c_sharp
            clojure
            cmake
            comment
            commonlisp
            cpp
            css
            diff
            dockerfile
            editorconfig
            fish
            git_config
            git_rebase
            gitattributes
            gitcommit
            gitignore
            go
            gpg
            html
            hyprlang
            ini
            java
            javadoc
            javascript
            jq
            jsdoc
            json
            json5
            kdl
            kitty
            latex
            lua
            luadoc
            make
            markdown
            markdown_inline
            meson
            nix
            nu
            powershell
            printf
            python
            regex
            rst
            rust
            scheme
            ssh_config
            sway
            # tmux # removed in unstable
            todotxt
            toml
            typescript
            vim
            vimdoc
            xcompose
            xml
            xresources
            yaml
            yuck
            # zathurarc # removed in unstable
            zig
            ziggy
            ziggy_schema
            zsh
          ];
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
