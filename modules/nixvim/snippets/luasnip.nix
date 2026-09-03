{ ... }:
{
  flake.nixvimModules.plugins =
    { ... }:
    {
      plugins.friendly-snippets.enable = true;

      plugins.luasnip = {
        enable = true;
        fromLua = [
          {
            paths = ./.;
            # include = [ ".*[.]lua" ]; # only loads *.lua files by default (and can only do that)
          }
        ];
      };
    };
}
