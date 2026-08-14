{
  self,
  inputs,
  ...
}:
let
  tabLen = 4;
in
{
  config.flake.homeModules.nixvim_options =
    { pkgs, ... }@a:
    let
      lua = a.lib.nixvim.mkRaw;
    in
    {
      #NOTE: see ../nix/options.nix
      opts = {
        # /*
        # * format
        # ==========
        # */
        # tabstop = tabLen;
        # softtabstop = tabLen;
        # shiftwidth = tabLen;
        #
        # swapfile = true;
        # # directory = ".";
        # # backup = true;
        # # backupdir = (lua "vim.fn.stdpath('data') .. '/bakkupp//'")
        # undofile = true;
        # # undodir = (lua "vim.fn.stdpath('state') .. '/exampleUndoDir//'")
        # undolevels = 1723;
        # confirm = true;
        #
        # /*
        # ==========
        # *  look
        # ==========
        # */
        # number = true;
        # relativenumber = true;
        #
        # cursorline = true;
        # colorcolumn = "-20,+0";
        #
        # wrap = false;
        # showmatch = true;
        # showmode = false;
        #
        # list = true;
        # listchars = {
        #   eol = "󰌑"; #  ␤ 󰌑 
        #   tab = "⇥ "; # ↣ ↪ ⇢ ⇛ ⇒ ⇨ ⇥ 󰌒 »
        #   # multispace = (lua /* lua */ "string.rep(' ', (vim.o.ts - 1)) .. '␣'"); # mark "shiftwidth" tabs
        #
        #   trail = "·"; # ␣ 󱁐 · ␠
        #   lead = " ";
        #   nbsp = "⍽";
        #   extends = "󰶻"; #  →⃨
        #   precedes = "󰶺"; #  ←
        # };
        #
        # fillchars = {
        #   foldopen = "";
        #   foldclose = ""; # "",
        #   fold = "·"; # · " "
        #   foldsep = ""; # " ",
        #   diff = "╱";
        #   eob = " ";
        # };
        #
        # breakindent = true;
        #
        # ruler = false;
        # signcolumn = "yes";
        #
        # termguicolors = true;
        #
        # winborder = ".,-,.,¦,˙,-,˙,¦";
        #
        # /*
        # ==========
        # *  feel
        # ==========
        # */
        # ignorecase = true;
        # smartcase = true;
        #
        # inccommand = "split";
        # virtualedit = "block";
        #
        # scrolloff = 10;
        # sidescrolloff = 10;
        #
        # foldlevel = 99;
        # foldmethod = "indent";
        # foldtext = "";
        #
        # smarttab = true;
        # smartindent = true; # TODO: cindent for nix files
        #
        # mouse = "nvc";
        # selectmode = "mouse";
        #
        # updatetime = 250;
        # timeoutlen = 222;
        #
        # splitright = true;
        # splitbelow = true;
        #
        # splitkeep = "cursor";
        # lazyredraw = true;
        #
        # textwidth = 100;
        #
        # wildmode = "longest:full";
        # wildoptions = "fuzzy,pum,tagfile";
      };

      globals = {
        # have_nerd_font = true;
        #
        # loaded_node_provider = 0;
        # loaded_perl_provider = 0;
        # loaded_ruby_provider = 0;
        # markdown_recommended_style = 0;
      };

      # extraFiles = {
      #   "autoload/nix_options.lua".text = /*lua*/ ''
      #     vim.opt.wrapoff:append("<>[]hl");
      #     vim.opt.shortmess:append("as");
      #   '';
      # };

      diagnostic.settings = {
        update_in_insert = false;
        severity_sort = false;
        # float = {
        #   border = "rounded";
        #   source = "if_many";
        # };
        # underline.severity.min = lua "vim.diagnostic.severity.INFO";
        #
        # virtual_text = false;
        # # virtual_text.virt_text_pos = "eol";
        # virtual_lines = {
        #   current_line = true;
        #   severity.min = lua "vim.diagnostic.severity.WARN";
        # };

        # TEST:
        jump.on_jump = lua "on_jump";
      };
    };
}
