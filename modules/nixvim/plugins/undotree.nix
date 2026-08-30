{ self, inputs, ... }@top:
let
  plugin_name = "undotree";
in
{
  flake.nixvimModules.${plugin_name} =
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
      #BUG: regular undotree did not install???
      # plugins.undotree = { enable = true; };

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "atone";
          src = pkgs.fetchFromGitHub {
            owner = "XXiaoA";
            repo = "atone.nvim";
            rev = "b5ebb6b27693fa759899b33c6fac787611e08a39";
            hash = "sha256-JG61boskf9KG1R5STS87xzsmWQXAWws/DddiHfJ20UQ=";
          };
        })
      ];
      extraConfigLuaList = [
        # lua
        ''
          require("atone").setup({
              layout = {
                  ---@type "left"|"right"
                  direction = "right", -- "left",
                  ---@type "adaptive"|number
                  --- adaptive: adapt to width of tree graph
                  --- float < 1: width = vim.o.columns * value
                  --- integer >= 1: absolute width
                  width = 0.25,
              },
              -- diff for the node under cursor
              -- shown under the tree graph
              diff_cur_node = {
                  enabled = true,
                  --- The diff window's height is set to a specified percentage of the original (namely tree graph) window's height.
                  split_percent = 0.3,
                  ---@type "adaptive"|number
                  --- adaptive: same width as tree window (default)
                  --- float < 1: width = vim.o.columns * value
                  --- integer >= 1: absolute width
                  --- Note that non-adaptive values create a float diff window anchored to a hidden
                  --- dummy split window. this is an implementation detail that may cause
                  --- unexpected edge-case bugs in certain window layouts.
                  width = "adaptive",
                  -- Use TreeSitter to highlight the source code inside diff hunks.
                  treesitter = true,
                  -- Highlight the exact changed word ranges inside modified lines.
                  inline_diff = true,
              },
              -- automatically update the buffer that the tree is attached to
              -- only works for buffer whose buftype is <empty>
              auto_attach = {
                  enabled = true,
                  excluded_ft = { "oil" },
              },
              marks = {
                  persist = true,
                  persist_path = vim.fn.stdpath("data") .. "/atone_marks.json",
                  --- finders are tried in order. "builtin" is always available.
                  finders = { "telescope", "builtin" }, -- "fzf-lua",
              },
              keymaps = {
                  tree = {
                      quit = { "<C-c>", "q" },
                      next_node = "j", -- support v:count
                      pre_node = "k", -- support v:count
                      jump_to_G = "G",
                      jump_to_gg = "gg",
                      undo_to = "<CR>",
                      set_mark = "m",
                      delete_mark = { "x", "X" },
                      delete_all_marks = "dM",
                      goto_mark = { "'", "`" },
                      mark_picker = "s",
                      help = { "?", "g?" },
                      float_diff = "gd",
                  },
                  auto_diff = {
                      quit = { "<C-c>", "q" },
                      help = { "?", "g?" },
                      undo = "u",
                      redo = "<C-r>",
                      float_diff = "gd",
                  },
                  help = {
                      quit_help = { "<C-c>", "q" },
                  },
              },
              diff_float = {
                  --- width of the diff float as a fraction of the editor width (0–1)
                  width = 0.8,
                  --- height of the diff float as a fraction of the editor height (0–1)
                  height = 0.8,
                  --- close the centred diff float when it loses focus.
                  autoclose = true,
              },
              ui = {
                  -- refer to `:h 'winborder'`
                  border = "single",
                  -- compact graph style
                  compact = false,
                  node_label = {
                      custom = false,
                      ---@param ctx AtoneNodeLabelContext
                      ---@return AtoneNodeLabel
                      formatter = function(ctx)
                          return string.format(
                              "[%d] %s %s%s",
                              ctx.seq,
                              ctx.h_time,
                              ctx.bookmark or "",
                              ctx.is_sticky_ref and " [=]" or ""
                          )
                      end,
                      extmark_opts = { strict = false },
                  },
              },
          })

          vim.keymap.set("n", "<leader>U", ":Atone toggle<CR>", { desc = "[U]Undotree" })
          -- TEST:
          local function atone_toggler()
            local atone_is_closed = vim.bo.ft ~= "atone"
            if atone_is_closed then
              vim.cmd("Atone open")
            else
              vim.cmd("Atone close")
            end
          end
          vim.keymap.set("n", "<leader>a", function() atone_toggler() end, { desc = "Atone[t]toggle" })
        ''
      ];
    };
}
