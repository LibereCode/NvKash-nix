{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.nixvim_autocmds =
    {
      config,
      pkgs,
      ...
    }@args:
    let
      lua = args.lib.nixvim.mkRaw;
    in
    {
      autoGroups = {
        highlight-yank.clear = true;
      };

      autoCmd = [
        {
          event = "TextYankPost";
          group = "highlight-yank";
          callback =
            lua
              # lua
              ''
                function()
                  vim.hl.on_yank()
                end
              '';
          desc = "Highlight on TextYankPost";
        }
      ];
    };
}
