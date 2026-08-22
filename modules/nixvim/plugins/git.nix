{ self, inputs, ... }@top:
let
  pluginName = "git";
in
{
  flake.nixvimModules.plugins =
    {
      pkgs,
      lib,
      config,
      ...
    }@a:
    # let
    #   inherit (lib.nixvim) mkRaw;
    # in
    {
      plugins = {
        tinygit = {
          enable = true;

          # lazyLoad.settings = {
          #   cmd = "Foobar";
          #   keys = [
          #     { __unkeyed-1 = "<leader>idk"; __unkeyed-3 = "<CMD>Foobar sub<CR>"; desc = "Foo bar"; }
          #   ];
          # };

          # See defaults(?): <https://github.com/chrisgrieser/nvim-tinygit/#configuration>
          settings = {
            commit = {
              keepAbortedMsgSecs.__raw = "60 * 10";
              spellcheck = true;
              subject = {
                autoFormat.__raw = ''
                  function(subject)
                    -- remove trailing dot https://commitlint.js.org/reference/rules.html#body-full-stop
                    subject = subject:gsub("%.$", "")

                    -- sentence case of title after the type
                    subject = subject
                      :gsub("^(%w+: )(.)", function(c1, c2) return c1 .. c2:lower() end) -- no scope
                      :gsub("^(%w+%b(): )(.)", function(c1, c2) return c1 .. c2:lower() end) -- with scope
                    return subject
                  end
                '';
                enforceType = true;
              };
            };
            stage = {
              moveToNextHunkOnStagingToggle = true;
            };
            statusline = {
              blame = {
                hideAuthorNames = [
                  "John Doe"
                  "johndoe"
                ];
                ignoreAuthors = [
                  "🤖 automated"
                ];
                maxMsgLen = 55;
              };
            };
          };

          luaConfig.post = ''
              do
                -- tinygit
                local map = vim.keymap.set
                local tinygit = require("tinygit")
                map( "n", "<leader>ga", function() tinygit.interactiveStaging() end, { desc = "(tiny)git add" })
                map( "n", "<leader>gc", function() tinygit.smartCommit() end, { desc = "(tiny)git commit" })
                map( "n", "<leader>gp", function() tinygit.push() end, { desc = "(tiny)git push" })

                -- See ./toggleterm.nix
                -- NOTE: [lazygit](https://github.com/akinsho/toggleterm.nvim#custom-terminals)
                local Terminal  = require('toggleterm.terminal').Terminal
                local lazygit = Terminal:new({
                  cmd = "lazygit",
                  dir = "git_dir",
                  direction = "float",
                  float_opts = {
                    border = "double",
                  },
                  -- function to run on opening the terminal
                  on_open = function(term)
                    vim.cmd("startinsert!")
                    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
                  end,
                  -- function to run on closing the terminal
                  on_close = function(term)
                    vim.cmd("startinsert!")
                  end,
              })

              function _lazygit_toggle()
                lazygit:toggle()
              end
              map("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "lazy💤[g]git"})
            end
          '';
        };
      };
    };
}
