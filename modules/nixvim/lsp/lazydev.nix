{ self, inputs, ... }@top:
let
  pluginName = "lazydev";
in
{
  flake.nixvimModules.plugins =
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
      plugins = {
        ${pluginName} = {
          enable = true;

          settings = {
            enabled = lib.nixvim.mkRaw ''
              function(root_dir)
                -- always enable unless `vim.g.lazydev_enabled = false`
                if vim.g.lazydev_enabled ~= nil then
                  -- print('lazydev enabled == false (uv: vim.f.lazydev_enabled == false)')
                  return vim.g.lazydev_enabled
                end

                local block_files = { ".luarc.json", ".luarc.jsonc", ".emmyrc.json", ".emmyrc.lua" }
                local block_files_exist = false
                for _, file in ipairs(block_files) do
                  block_files_exist = vim.uv.fs_stat(root_dir .. "/" .. file) ~= nil
                end
                -- disable when a .luarc.json{,c} file is found
                if block_files_exist then
                  -- print('lazydev enabled == false (uv: luarc exist)')
                  return false
                end

                -- print('lazydev enabled == true')
                return true
              end
            '';
            library = [
              # ~/.local/lib/foobar # absolute library path
              # lazy.nvim # relative from plugin dir (~/.local/share/nvim ???)

              {
                # It can also be a table with trigger words / mods
                path = "$" + "{3rd}/luv/library"; # Only load luvit types when ...
                words = [ "vim%.uv" ]; # ... when the `vim.uv` word is found
              }
              {
                path = "LazyVim"; # Only load the lazyvim library when ...
                words = [ "LazyVim" ]; # ... when the `LazyVim` global is found
              }
              {
                path = "wezterm-types"; # Load the wezterm types when ...
                mods = [ "wezterm" ]; # ... when the `wezterm` module is required (plug: DrKJeff16/wezterm-types)
              }
              {
                path = "xmake-luals-addon/library"; # Load the xmake types when ...
                files = [ "xmake-luals-addon/library" ]; # ... when opening file named `xmake.lua`
              }
            ];
            runtime = lib.nixvim.mkRaw "vim.env.VIMRUNTIME";
          };
        };

        blink-cmp.settings = {
          sources.providers = {
            lazydev = {
              name = "LazyDev";
              module = "lazydev.integrations.blink";
              # make lazydev completions top priority (see `:h blink.cmp`)
              score_offset = 100;
            };
          };
        };
      };
    };
}
