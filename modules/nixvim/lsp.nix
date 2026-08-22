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

      #INFO: https://nix-community.github.io/nixvim/lsp/index.html
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

            (map_func "<leader>k" /* lua */ "vim.diagnostic.jump({ count=-1, float=true })" {
              desc = "diagnostic next";
            })
            (map_func "<leader>j" /* lua */ "vim.diagnostic.jump({ count=1, float=true })" { desc = "diagnostic prev"; })
            (map_func "<leader>lx" /* lua */ "vim.cmd('LspStop') " { desc = "stop"; })
            (map_func "<leader>ls" /* lua */ "vim.cmd('LspStart') " { desc = "start"; })
            (map_func "<leader>ls" /* lua */ "vim.cmd('LspRestart') " { desc = "restart"; })

            (map_func "<C-j>" /* lua */ "vim.lsp.buf.hover()" { mode = "i"; })

            (map_func "gd" # "<leader>sld"
              /* lua */ "require('telescope.builtin').lsp_definitions()"
              { desc = "telescope definitions"; }
            )
          ];

        servers = {
          "*" = {
            config = {
              capabilities.textDocument.semanticTokens.multilineTokenSupport = true;
              root_markers = [
                ".git"
              ];
            };
          };

          bashls.enable = true; # bash / shell

          # c / c++
          clangd = {
            enable = true;
            config = {
              cmd = [
                "clangd"
                "--background-index"
              ];
              filetypes = [
                "c"
                "cpp"
              ];
              # root_markers = [ "compile_commands.json" "compile_flags.txt" ];
            };
          };

          fish_lsp.enable = true; # fish

          html.enable = true; # html

          gopls.enable = true; # go

          jdtls.enable = true; # java

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
          nixd = {
            enable = true;
            config = {
              settings = {
                nixd = {
                  nixpkgs = {
                    expr = "import <nixpkgs> { }";
                  };
                  #TODO:
                  ## Set these options via `:h exrc` and (.nvim.lua + .nvim/lsp/*.lua)
                  # options = {
                  #   nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.<hostname>.options";
                  #   home_manager.expr = "(builtins.getFlake (toString ./.)).homeConfigurations.\"<username>@<hostname>\".options";
                  # };
                };
              };
            };
          };

          qmlls.enable = true; # qml

          rust_analyzer.enable = true; # rust

          tombi.enable = true; # toml

          ts_ls.enable = true; # typescript

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

          zls.enable = true; # zig
        };
        # luaConfig.post = ''
        #   -- --[[ ========================
        #   --     LspProgress in statusbar
        #   -- -- ======================== ]]
        #   --
        #   -- ---@param events string|string[]
        #   -- ---@param augroupName string
        #   -- ---@param autoOpts vim.api.keyset.create_autocmd
        #   -- local function lsp_autocmd(events, augroupName, opts)
        #   --   local group = vim.api.nvim_create_augroup(augroupName, {clear = true})
        #   --   local autoOpts = vim.tbl_extend('force', {group = group}, opts)
        #   --   vim.api.nvim_create_autocmd(events, autoOpts)
        #   -- end
        #   -- lsp_autocmd({ "LspProgress" }, "LspProgress-nvim_echo", { -- best
        #   --   desc = [[
        #   --     LspProgress autocmd.
        #   --     Declared in: {file}`nixvim/nix/lsp.nix`.
        #   --   ]],
        #   --   callback = function(ev)
        #   --       local val = ev.data.params.value
        #   --       local client = vim.lsp.get_client_by_id(ev.data.client_id)
        #   --       if client then
        #   --         local message = val.message
        #   --         if message then
        #   --           message = "  " .. message
        #   --         else
        #   --           message = " ✔ DONE"
        #   --         end
        #   --         vim.api.nvim_echo({ { message } }, false, {
        #   --           id = "lsp." .. ev.data.client_id,
        #   --           kind = "progress",
        #   --           source = "vim.lsp",
        #   --           title = "[" .. client.name .. "] " .. val.title,
        #   --           status = val.kind ~= "end" and "running" or "success",
        #   --           percent = val.percentage,
        #   --         })
        #   --       end
        #   --   end,
        #   -- })
        # '';
      };
    };
}
