{ self, inputs, ... }@top:
let
  plugin_name = "telescope";
in
{
  flake.nixvimModules.${plugin_name} =
    { pkgs, lib, ... }@a:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      config.plugins = {
        ${plugin_name} = {
          enable = true;

          #XXX: (source) { ... action = "<cmd>Telescope ${actionStr}<cr>"; ... } (no lua !!)
          # keymaps = { };

          # extensions = {}; # TODO:
          # settings = {}; # TODO:

          luaConfig.post = ''
            local tb = require("telescope.builtin")
            local teleThemes = require("telescope.themes")

            ---@param keys string "<leader>" .. `keys` ; (post nvim 0.13: string|string[])
            ---@param cmd_base string require("telescope.builtins")[`cmd_base`]()
            ---@param cmd_opts table require("telescope.builtins")[cmd_base](`cmd_opts`)
            ---@param opts vim.keymap.set.Opts? extra options. default: `{}`
            ---@param mode string|string[]? default: `"n"`
            local function teleMap(keys, cmd_base, cmd_opts, opts, mode)
                keys = "<leader>" .. keys
                mode = mode or "n"
                opts = opts or {}
                local cmd = function()
                    tb[cmd_base](type(cmd_opts) == "function" and cmd_opts() or cmd_opts)
                end
                vim.keymap.set(mode, keys, cmd, opts)
            end

            -- Quick access
            teleMap("r", "resume", {}, { desc = "[r]esume Telescope" })

            teleMap("/", "current_buffer_fuzzy_find", {
                layout_strategy = "bottom_pane",
                layout_config = {
                    height = 0.4,
                    preview_cutoff = 69,
                    prompt_position = "bottom",
                },
                -- preview_width = 0.6,
                winblend = 10,
                wrap_results = true,
            }, { desc = "Fzf [/] current buf" })

            -- search/select --  See `:help telescope.builtin` for information about particular keys
            teleMap("sb", "live_grep", {
                grep_open_files = true,
                prompt_title = "LiveGrep open Buffers",
            }, { desc = "live_grep open_[b]ufs" })
            teleMap("sd", "diagnostics", {}, { desc = "diagnostics" })
            vim.keymap.set("n", "sm", function() tb.marks(teleTehemes.get_dropdown()) end, { desc = "[m]arks" })
            teleMap("sp", "live_grep", {
                cwd = vim.fn.expand("%:p:h"), -- %:p = full-path ; %:h = directory name
                prompt_title = "LiveGrep PWD",
            }, { desc = "live_grep [p]PWD" })
            teleMap("ss", "live_grep", {}, { desc = "[s]earch (live_grep)" })
            teleMap("st", "builtin", {}, { desc = "[t]elescope-builtins" }) -- TODO: builtins->todo
            teleMap("sw", "grep_string", {}, { desc = "[w]word" }, { "n", "x" }) -- 'v'
            teleMap("s:", "command_history", {}, { desc = "[:]cmd_history" }) -- maybe in find instead?
            teleMap('s"', "registers", {}, { desc = '["]registers' })
            teleMap("s/", "current_buffer_fuzzy_find", {
                layout_strategy = "flex",
                height = 25, -- 0.4
                preview_cutoff = 120,
                -- prompt_position = 'top', -- "bottom",
                width = 0.5,
            }, { desc = "Fzf [/] +BIG_preview" })

            -- find/files
            teleMap("fb", "buffers", {}, { desc = "buffers" })
            -- teleMap("fc", "find_files", { cwd = vim.fn.stdpath("config") }, { desc = "nvim [c]onfig" }) -- Shortcut for searching your Neovim configuration files
            teleMap("fd", "fd", {}, { desc = "fd[d]" })
            teleMap("ff", "fd", {}, { desc = "[f]files" }) -- fd=find_files
            teleMap("fh", "help_tags", {}, { desc = "[h]help" })
            teleMap("fk", "keymaps", {}, { desc = "[k]keymaps" })
            teleMap("fm", "man_pages", {}, { desc = "[m]men" })
            teleMap("fr", "oldfiles", {}, { desc = "[r]recent Files" })
            teleMap("f:", "commands", {}, { desc = "[:]commands" })

            -- other groups
            teleMap("df", "diagnostics", {}, { desc = "[f]ind diagnostics" })
            teleMap("bf", "buffers", {}, { desc = "find" })
            teleMap("up", "colorscheme", {}, { desc = "[p]ick Colorscheme" })
            -- teleMap('tC', "colorscheme", {}, {desc='live preview Colorscheme'})
          '';
        };

      };
    };
}
