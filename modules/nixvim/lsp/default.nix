{
  self,
  inputs,
  ...
}@top:
{
  flake.nixvimModules.lsp =
    {
      pkgs,
      lib,
      config,
      ...
    }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins = {
        #LspProgress
        fidget = {
          enable = true;
          settings = {
            notification = {
              window = {
                winblend = 72;
              };
            };
            progress = {
              display = {
                done_icon = "";
                done_ttl = 7;
                format_message = mkRaw ''
                  function(msg)
                    if string.find(msg.title, "Indexing") then
                      return nil -- Ignore "Indexing..." progress messages
                    end
                    if msg.message then
                      return msg.message
                    else
                      return msg.done and "Completed" or "In progress..."
                    end
                  end
                '';
                progress_icon = mkRaw ''{ "dots" }'';
              };
            };
          };
        };

        lspconfig.enable = true;
      };

      # extraPackages = with pkgs; [ alejandra ]; # nixfmt

      #INFO: According to docs, `config.plugins.lsp = {};` is deprecated,
      ## lspconfig (small) will move to `config.plugins.lspconfig = {};`, and
      ## server settings moved to here: `config.lsp = {};`
      ## <https://nix-community.github.io/nixvim/plugins/lspconfig/index.html>
      ## <https://nix-community.github.io/nixvim/lsp/index.html>
      ## best sauce (because it include lspconfig comment and URL):
      ## <https://nix-community.github.io/nixvim/plugins/lsp/index.html> <--
      lsp = {
        #TODO:
        # onAttach = /* lua */ ''
        #   -- Equivalent(?) to:
        #   -- autocmd("LspAttach", { ..., callback = function()
        #   --   <THIS>
        #   -- end, ... })
        # '';

        # inlayHints.enable = true; # BUG causes many errors
        inlayHints.enable = true; # no?

        ## keymaps on LspAttach
        keymaps =
          let
            map_lspBuf =
              key: lspBufAction:
              {
                mode ? "n",
                ...
              }@opt:
              let
                options = (removeAttrs opt [ "mode" ]) // {
                  desc = "[lsp] " + (opt.desc or lspBufAction);
                };
              in
              {
                inherit
                  key
                  lspBufAction
                  options
                  mode
                  ;
              };
            map_func =
              key: funcBody:
              {
                mode ? "n",
                ...
              }@opt:
              let
                options = (removeAttrs opt [ "mode" ]) // {
                  desc = "[lsp] " + (opt.desc or funcBody);
                };
                action = {
                  __raw = "function() ${funcBody} end";
                };
              in
              {
                inherit
                  key
                  action
                  options
                  mode
                  ;
              };
          in
          [
            # (map_lspBuf "gd" "definition" {}) # See: ./plugins/telescope.nix
            (map_lspBuf "gD" "references" { })
            (map_lspBuf "gt" "type_definition" { })
            (map_lspBuf "gi" "implementation" { })
            (map_lspBuf "K" "hover" { })

            (map_func "<leader>k" "vim.diagnostic.jump({ count=-1, float=true })" {
              desc = "diagnostic next";
            })
            (map_func "<leader>j" "vim.diagnostic.jump({ count=1, float=true })" { desc = "diagnostic prev"; })
            (map_func "<leader>lx" "vim.cmd('LspStop') " { desc = "stop"; })
            (map_func "<leader>ls" "vim.cmd('LspStart') " { desc = "start"; })
            (map_func "<leader>ls" "vim.cmd('LspRestart') " { desc = "restart"; })

            (map_func "<C-j>" "vim.lsp.buf.hover()" { mode = "i"; })

            (map_func "gd" "require('telescope.builtin').lsp_definitions()" { desc = "telescope definitions"; })
          ];

        #TODO: disable most ; instead use:
        ## + devenv (get lsp)
        ## + .nvim.lua (to enable them)
        servers = {
          "*" = {
            config = {
              capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
              root_markers = [
                ".git"
              ];
            };
          };

          # ast_grep.enable = true; # c-like *

          bashls.enable = true; # bash / shell

          # biome.enable = true; # js/ts/html/...

          # # c / c++
          # clangd = {
          #   enable = true;
          #   config = {
          #     cmd = [
          #       "clangd"
          #       "--background-index"
          #     ];
          #     filetypes = [
          #       "c"
          #       "cpp"
          #     ];
          #     # root_markers = [ "compile_commands.json" "compile_flags.txt" ];
          #   };
          # };

          cssls.enable = true; # css

          # XXX It started either way ...
          # # See also: lua_ls and ./lazydev.nix
          # emmylua_ls = {
          #   enable = true;
          #   config = {
          #     # NOTE more restrictive root_markers
          #     root_markers = [
          #       ".emmyrc.lua"
          #       ".emmyrc.json"
          #     ];
          #     workspace_required = true;
          #   };
          # };

          fish_lsp.enable = true; # fish

          # gopls.enable = true; # go

          html.enable = true; # html

          # jdtls.enable = true; # java

          # json*
          jsonls = {
            enable = true;
            config = {
              filetypes = [
                "json"
                "jsonc"
              ];
            };
          };

          lemminx.enable = true; # xml

          # See: <https://github.com/neovim/nvim-lspconfig/blob/master/lsp/lua_ls.lua>
          # See luaConfig.port bellow for lua_ls config
          # NOTE Configure with lazydev instead
          lua_ls.enable = true; # lua

          marksman.enable = true; # markdown

          # nix
          nil_ls = {
            enable = true;
            config = {
              settings = {
                formatting = [ "nixfmt" ]; # "alejandra"
                nix.flake = {
                  autoArchive = true;
                  autoEvalInputs = true;
                };
                #TODO: disable lsp-function: goto definition
                ## nixd also has it
              };
            };
          };
          # NOTE: See below, I will use luaConfig.post = '' ... '';
          nixd = {
            enable = true;
            config = {
              settings = {
                nixd = {
                  nixpkgs = {
                    expr = "import <nixpkgs> { }";
                  };
                  formatting = {
                    command = [ "${pkgs.nixfmt-rs}/bin/nixfmt" ];
                  };
                };
              };
            };
          };

          ## enable in treefmt (devenv)
          # prettierd.enable = true; # yml/json/toml/...

          # qmlls.enable = true; # qml

          ## enable in treefmt (devenv)
          # ruff.enable = true; # python

          rumdl.enable = true; # markdown

          # shuck.enable = true; # ba/z/sh # Doesent exist yet for nixos D:

          # rust_analyzer.enable = true; # rust

          ## enable in treefmt (devenv)
          # stylua.enable = true; # lua

          superhtml.enable = true; # html

          tombi.enable = true; # toml

          # ts_ls.enable = true; # typescript

          ty.enable = true; # python

          # text / markdown (spellcheck)
          vale_ls = {
            enable = true;
            config = {
              filetypes = [
                "text"
                "markdown"
              ];
            };
          };

          yamlls.enable = true; # yaml

          # zls.enable = true; # zig
        };
        luaConfig.post = ''
          -- -- Setting nixd lsp-config with basically Lua+Nix voodoo magic...
          -- -- See <https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md#where-to-place-the-configuration>
          -- do
          --   local function iopopen_val(cmd)
          --       local cmd_res = io.popen(cmd) or ""
          --       if cmd_res then
          --           local cmd_res_read = cmd_res:read("l")
          --           cmd_res:close()
          --           return cmd_res_read
          --       end
          --   eANNER (right) nd
          --   -- DECLARATIVE    
          --   local host = iopopen_val([[{$pkgs.hostname}/bin/hostname]])
          --   local user = iopopen_val([[{$pkgs.coreutils}/bin/whoami]])
          -- 
          --   local root_markers = { "flake.nix", ".git" }
          --   local root_path = vim.fs.root(0, root_markers) or vim.env.PWD
          -- 
          --   -- local get_flake_base = '(builtins.getFlake (builtins.toString ./.)).'
          --   local get_flake_base = '(builtins.getFlake ' .. root_path .. ').'
          -- 
          --   ---TEST path to $HOME/nixos
          --   local nixos_opts = get_flake_base .. 'nixosConfigurations.' .. host .. '.options'
          --   local hm_opts
          --   hm_opts = nixos_opts .. '.home-manager.users.type.getSubOptions []'
          --   if not vim.uv.fs_stat("/etc/NIXOS") then
          --     hm_opts = get_flake_base .. 'homeConfigurations.' .. user .. '@' .. host .. '.options'
          --   end
          -- 
          --   local flake_parts_opts = get_flake_base .. 'debug.options'
          --   local flake_parts_perSys_opts = get_flake_base .. 'currentSystem.options'
          -- 
          --   vim.lsp.config("nixd", {
          --     -- cmd = { [[{$pkgs.nixd}/bin/nixd]] },
          --     -- filetypes = { "nix" },
          --     -- root_markers = root_markers,
          --     settings = {
          --       nixd = {
          --         nixpkgs = {
          --           expr = "import <nixpkgs> { }",
          --         },
          --         formatting = {
          --           command = { [[{$pkgs.nixfmt-rs}/bin/nixfmt]] },
          --         },
          --         --TODO: try again some time, didnt work well this time
          --         -- options = {
          --         --   nixos = { expr = nixos_opts },
          --         --   home_manager = { expr = hm_opts },
          --         --   ["flake-parts"] = { expr = flake_parts_opts },
          --         --   ["flake-parts2"] = { expr = flake_parts_perSys_opts },
          --         -- },
          --         -- diagnostic = {},
          --       },
          --     },
          --   })
          -- end

        '';

      };
    };
}
