{ ... }:
let
  pluginName = "obsidian";
in
{
  flake.nixvimModules.${pluginName} =
    { ... }:
    let
      workspacesDir = "~/Notes/obsidian";
    in
    {
      plugins = {
        obsidian = {
          enable = true;

          ## Default: <https://github.com/obsidian-nvim/obsidian.nvim/blob/main/lua/obsidian/config/default.lua>
          ## 󱞪 (RAW): [./_obsidian-default.lua](https://raw.githubusercontent.com/obsidian-nvim/obsidian.nvim/refs/heads/main/lua/obsidian/config/default.lua)
          settings = {
            legacy_commands = false;
            picker.name = "telescope.nvim";

            new_notes_location = "current_dir";
            workspaces = [
              {
                name = "default";
                path = workspacesDir;
              }
            ];
            checkbox.order = [
              " "
              "-"
              "x"
              # "?"
              # "!"
              # "+"
              # "="
            ];
          };

          luaConfig = {
            pre = # lua
              ''
                ---`plugins.obsidian.luaConfig.pre`:
                ---{{

                ---Could be inline (and inside do-end scope), but this gives better syntax-highlighting...
                ---Base directory of where to keep obsidian-vaults.
                local obsidian_workspace = [[${workspacesDir}]]
                do
                  ---INFO Fixes "directory doesn't exist" error (especially during `nix flake check`)
                  vim.fn.mkdir(vim.fn.expand(obsidian_workspace), "p" )
                end

                ---}}
              '';
            post = ''
              ---`plugins.obsidian.luaConfig.post`:
              ---{{

              ---TEST: TEMP
              -- local obsidian_workspace = "~/Notes/obsidian"

              do
                vim.api.nvim_create_user_command("ObsidianJournal", function(opts)
                  ---`print` and `input` to get `day_mod`
                  ---@return integer? day_mod answer from input
                  local function day_mod_input()
                    vim.print(
                      "Journal entry for n days from today.",
                      "0 = today",
                      "1 = tomorrow",
                      "-1 = yesterday",
                      "61 = in 2 months",
                      "<empty> = today",
                      "q = <cancel>"
                    )
                    local input = vim.fn.input("Type _number_ and <Enter> (empty defaults to '0'; non-number cancels): ")
                    local day_mod = input == "" and 0 or tonumber(input) or nil
                    return day_mod
                  end

                  local day_mod = tonumber(opts.args) or day_mod_input()
                  ---Cancel if day_mod_input return nothing (ie: non-integer)
                  if not day_mod then
                    return
                  end

                  ---@type osdateparam
                  ---@diagnostic disable-next-line: assign-type-mismatch
                  local date = os.date("*t")
                  date.day = date.day + tonumber(day_mod) ---yes, this work
                  local time = os.time(date)

                  ---@type osdateparam
                  ---@diagnostic disable-next-line: assign-type-mismatch
                  local date_time = os.date("*t", time)
                  local year, month, day = tostring(date_time.year), tostring(date_time.month), tostring(date_time.day)
                  local journal_dir = vim.fn.expand(obsidian_workspace .. "/journal" .. "/" .. year .. "/" .. month)
                  local journal_entry = journal_dir .. "/" .. day .. ".md"
                  -- vim.print(journal_dir, journal_entry) ---Debug

                  vim.fn.mkdir(journal_dir, "p")
                  if not vim.uv.fs_stat(journal_entry) then
                    local data = {
                      "---",
                      "id: " .. year .. "-" .. month .. "-" .. day,
                      "aliases: []",
                      "tags:",
                      "  - daily-notes",
                      "---",
                    }
                    vim.fn.writefile(data, journal_entry)
                  end
                  vim.cmd.edit({ args = { journal_entry } })
                end, {
                  desc = "A better version of `:Obsidian today/tomorrow/yesterday`. (Declared in nixvim/text/obsidian.nix)",
                  nargs = "?",
                })

                ---[n]otes -> [o]bsidian
                vim.keymap.set("n", "<leader>no", "<CMD>Obsidian<CR>", { desc = "[o]obsidian menu" })
                vim.keymap.set("n", "<leader>nj", "<CMD>ObsidianJournal<CR>", { desc = "obsidian [j]journal" })
              end

              ---}}
            '';
          };
        };
      };
    };
}
