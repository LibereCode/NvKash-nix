{ self, inputs, ... }@top:
{
  flake.homeModules.nixvim_mappings =
    { pkgs, ... }@a:
    let
      # mkLua = programs.nixvim.lib.nixvim.mkRaw;
      lua = a.lib.nixvim.mkRaw;
      keymap = mode: key: action: options: {
        inherit mode;
        inherit key;
        inherit action;
        inherit options;
      };
    in
    {
      keymaps = [
        # {
        #   key = "<leader>e";
        #   action = mkLua /* lua */ ''
        #     function()
        #         vim.cmd("Ex")
        #         map("n", "<leader>e", "<CMD>Rex<CR>")
        #     end
        #   '';
        #   options = {
        #     desc = "Ex";
        #   };
        # }

        /*
          * =============
          *      Cmd
          * =============
        */

        # (keymap "n" "<ESC>" /* vim */ ":nohl<CR>:<C-c>" {
        #   silent = true;
        #   remap = true;
        # })
        # (keymap "n" "<C-;>" (mkLua /* lua */ ''
        #   function()
        #     if vim.fn.getcmdwintype() == ":" then
        #       vim.cmd.q()
        #     else
        #       vim.api.nvim_input("q:") -- see :h 'cedit'
        #     end
        #   end
        # '') { desc = "toggle [:]cmd-like window"; })
        # (keymap "c" "<C-;>" (mkLua /* lua */ ''
        #   function()
        #     vim.api.nvim_input(vim.o.cedit)
        #   end
        # '') { desc = "enter [:]cmd-window"; })
        # (keymap "c" "<C-a>" "<HOME>" { silent = true; })
        # (keymap "c" "<C-b>" "<S-Left>" { })
        # (keymap "c" "<C-f>" "<S-Right>" { })
        #
        # (keymap "n" "<C-s>" /* vim */ ''
        #   :write<CR>
        # '' { remap = true; })
        # (keymap "n" "<C-q>" /* vim */ ''
        #   :quit<CR>
        # '' { })
        # (keymap "n" "<leader>qr" /* vim */ ''
        #   :restart<CR>
        # '' { })

        /*
          * =============
          *    buffer
          * =============
        */

        # (keymap "n" "<S-H>" /* vim */ ''
        #   :bp<CR>
        # '' { })
        # (keymap "n" "<S-L>" /* vim */ ''
        #   :bn<CR>
        # '' { })

        /*
          * =============
          *    window
          * =============
        */

        # (keymap "n" "<C-h>" "<C-w>h" { })
        # (keymap "n" "<C-j>" "<C-w>j" { })
        # (keymap "n" "<C-k>" "<C-w>k" { })
        # (keymap "n" "<C-l>" "<C-w>l" { })
        # (keymap "n" "<C-M-h>" "<C-w>H" { })
        # (keymap "n" "<C-M-j>" "<C-w>J" { })
        # (keymap "n" "<C-M-k>" "<C-w>K" { })
        # (keymap "n" "<C-M-l>" "<C-w>L" { })

        /*
          * =============
          *      QoL
          * =============
        */

        # (keymap "n" "<C-c>" "gcc" { remap = true; })
        # (keymap "x" "<C-c>" "gc" { remap = true; })
        #
        # (keymap "n" "j" "gj" { silent = true; })
        # (keymap "n" "k" "gk" { silent = true; })

        /*
          * =============
          *   terminal
          * =============
        */

        # (keymap "t" "<C-ESC>" "<C-\\><C-n>" { remap = true; })
        # (keymap "t" "<ESC><ESC>" "<C-\\><C-n>" { remap = true; })
        #
        # (keymap "" "<leader>tv" ":vert te<CR>" { desc = "[v]vert terminal"; })
        # (keymap "" "<leader>th" ":hor te<CR>" { desc = "[h]hor terminal"; })
        # (keymap "" "<leader>tT" (mkLua /* lua */ ''
        #   function() vim.cmd.terminal() end
        # '') { desc = "[T]Terminal buffer"; })
        # #TODO: <M-t> = toggle-term (plugin)

        /*
          * =============
          *  diagnostic
          * =============
        */

        # (keymap "n" "<leader>do" (mkLua /* lua */ ''
        #   function() vim.diagnostic.setloclist() end
        # '') { desc = "l[o]clist"; })
        # (keymap "n" "<leader>dc" (mkLua /* lua */ ''
        #   function() vim.diagnostic.open_float({ scope = 'b' }) end
        # '') { desc = "[c]ursor diagnostic"; })
        # (keymap "n" "<leader>dd" (mkLua /* lua */ ''
        #   function() vim.diagnostic.open_float() end
        # '') { desc = "line [d]diagnostic"; })
        # (keymap "n" "<leader>db" (mkLua /* lua */ ''
        #   function() vim.diagnostic.open_float({ scope = "b" }) end
        # '') { desc = "[b]uffer diagnostic"; })
        # (keymap "n" "<leader>dl"
        #   (mkLua /* lua */ ''
        #     function() vim.cmd('tabnew ' .. vim.fn.stdpath("log")) end
        #   '') # -- vim.cmd('tabnew ' .. vim.lsp.log.get_filename()) end
        #   { desc = "open [l]logs"; }
        # )
        # (keymap "n" "<leader>dt" (mkLua /* lua */ ''
        #   function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end
        # '') { desc = "[t]toggle diagnostic (global)"; })
        # (keymap "n" "<leader>ud" (mkLua /* lua */ ''
        #   function() vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = 0 }), { bufnr = 0 }) end
        # '') { desc = "[d]diagnostic"; })
      ];
    };
}
