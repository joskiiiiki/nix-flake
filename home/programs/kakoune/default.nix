{ pkgs, ... }:
let
  # occivink/kakoune-filetree isn't packaged in nixpkgs. It's just a .kak +
  # .perl script pair, so package it the same way nixpkgs' own kakounePlugins
  # derivations are shaped (files under share/kak/autoload get auto-sourced
  # by Kakoune, see pkgs/applications/editors/kakoune/wrapper.nix).
  kakoune-filetree = pkgs.stdenvNoCC.mkDerivation {
    pname = "kakoune-filetree";
    version = "unstable-2026-10-27";
    src = pkgs.fetchFromGitHub {
      owner = "occivink";
      repo = "kakoune-filetree";
      rev = "be8158ce83e295830a48057c0580fe17a843d661";
      hash = "sha256-EfSZb5plZSU7obzLsxv0pV5G7dpolW1a4c3LLdWB5fg=";
    };
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/kak/autoload/plugins/kakoune-filetree
      cp filetree.kak filetree.perl $out/share/kak/autoload/plugins/kakoune-filetree/
      runHook postInstall
    '';
  };
in
{
  imports = [
    ./languages.nix
  ];

  home.packages = with pkgs; [
    kak-tree-sitter
    kakoune-lsp
    tree # kakoune-filetree dependency
    perl # kakoune-filetree dependency
    file # kak-lsp/fzf-kak shell out to this for type/root detection
  ];

  xdg.configFile."kak/colors/vercel.kak".source = ./colors/vercel.kak;

  programs.kakoune = {
    enable = true;
    defaultEditor = false; # Helix stays $EDITOR/$VISUAL

    plugins = with pkgs.kakounePlugins; [
      fzf-kak
      auto-pairs-kak
      kakoune-filetree
    ];

    config = {
      colorScheme = "vercel";
      tabStop = 4;
      indentWidth = 4;
      incrementalSearch = true;
      autoInfo = [
        "command"
        "onkey"
        "normal"
      ];
      autoComplete = [
        "insert"
        "prompt"
      ];
      autoReload = "yes";
      showMatching = true; # mirrors Helix's always-on matching-bracket highlight

      ui = {
        statusLine = "bottom";
        assistant = "none";
        enableMouse = true;
      };

      # mirrors Helix's gutters = [diff, diagnostics, line-numbers, spacer] +
      # cursorline = true (relative = false, since Helix's own line-number
      # mode defaults to absolute and settings.nix never overrides it)
      numberLines = {
        enable = true;
        relative = false;
        highlightCursor = true;
      };
    };

    extraConfig = ''
      # ---------------------------------------------------------------------
      # auto-pairs: Helix always auto-closes brackets/quotes, so mirror that.
      # ---------------------------------------------------------------------
      enable-auto-pairs

      # ---------------------------------------------------------------------
      # cursorline (Helix: editor.cursorline = true)
      # ---------------------------------------------------------------------
      add-highlighter global/ line %{%val{cursor_line}} CursorLine

      # ---------------------------------------------------------------------
      # tree-sitter highlighting + text-objects (kak-tree-sitter)
      # One-time setup still required: run `ktsctl sync` to fetch/compile
      # grammars - that step needs network access and isn't something Nix
      # can pin here.
      #
      # kak-tree-sitter removes Kakoune's native (non-tree-sitter) highlighter
      # for a buffer once it takes over, and - per its own README - ships with
      # NO colorscheme faces defined for itself. It generates one `ts_<group>`
      # face per capture group (dots -> underscores, e.g. "keyword.control" ->
      # "ts_keyword_control"), each initially linked to its parent group (or
      # to the literal Kakoune face "default" for a root group) - see
      # kak-tree-sitter/src/kakoune/face.rs. Left untouched that makes every
      # token render in the plain foreground color. Re-point the *roots* here
      # (run after --init, so this wins) and every child face inherits the
      # color live through Kakoune's face-aliasing, no need to redefine leaves.
      # ---------------------------------------------------------------------
      evaluate-commands %sh{
          kak-tree-sitter --kakoune --init "$kak_session" --server --daemonize \
              --with-highlighting --with-text-objects
      }

      set-face global ts_attribute rgb:c472fb
      set-face global ts_comment rgb:a1a1a1
      set-face global ts_constant rgb:52a8ff
      set-face global ts_constructor rgb:62c073
      set-face global ts_embedded default
      set-face global ts_error rgb:f75f8f
      set-face global ts_function rgb:c472fb
      set-face global ts_hint rgb:a1a1a1
      set-face global ts_include rgb:f75f8f
      set-face global ts_info rgb:52a8ff
      set-face global ts_keyword rgb:f75f8f
      set-face global ts_label rgb:52a8ff
      set-face global ts_markup rgb:52a8ff
      set-face global ts_namespace rgb:c472fb
      set-face global ts_operator rgb:f75f8f
      set-face global ts_punctuation rgb:ededed
      set-face global ts_special rgb:52a8ff
      set-face global ts_string rgb:62c073
      set-face global ts_tag rgb:62c073
      set-face global ts_text rgb:ededed
      set-face global ts_type rgb:c472fb
      set-face global ts_variable rgb:ededed
      set-face global ts_warning rgb:ff9907
      # Three-way diff colors don't make sense inherited from one "ts_diff" root.
      set-face global ts_diff_plus rgb:62c073
      set-face global ts_diff_minus rgb:f75f8f
      set-face global ts_diff_delta rgb:ff9907

      # ---------------------------------------------------------------------
      # Completion scope: Kakoune's default `completers` includes
      # `word=all`, which pulls completion candidates from the *contents of
      # every open buffer* - including the kakoune-filetree sidebar buffer
      # once it's been opened, flooding the menu with tree/path noise.
      # `word=buffer` keeps word-completion to the current buffer, same as
      # Helix (LSP + local words only).
      # ---------------------------------------------------------------------
      set-option global completers filename word=buffer

      # ---------------------------------------------------------------------
      # LSP (kak-lsp) - completions, hover, diagnostics, etc. Per-language
      # server choices are overridden in languages.nix, loaded above this.
      # ---------------------------------------------------------------------
      evaluate-commands %sh{ kak-lsp --kakoune }
      lsp-enable
      # mirrors Helix's lsp.display-inlay-hints = true
      lsp-inlay-hints-enable global

      declare-option bool helix_inlay_hints_enabled true
      define-command -hidden lsp-inlay-hints-toggle %{
          evaluate-commands %sh{
              if [ "$kak_opt_helix_inlay_hints_enabled" = true ]; then
                  printf '%s\n' 'set-option global helix_inlay_hints_enabled false' 'lsp-inlay-hints-disable global'
              else
                  printf '%s\n' 'set-option global helix_inlay_hints_enabled true' 'lsp-inlay-hints-enable global'
              fi
          }
      }

      # ---------------------------------------------------------------------
      # Completion confirm: Kakoune's native model has no separate
      # "accept" key - selecting a candidate with <c-n>/<c-p> already
      # inserts it live, Tab/Space do nothing to the menu by default. Rebind
      # Tab/Shift-Tab to that selection while the completion menu is
      # actually visible (and only then, via InsertCompletionShow/Hide), so
      # it behaves like Helix/VSCode without touching Tab's normal
      # indent behavior the rest of the time.
      # ---------------------------------------------------------------------
      hook global InsertCompletionShow .* %{
          map window insert <tab> <c-n>
          map window insert <s-tab> <c-p>
      }
      hook global InsertCompletionHide .* %{
          unmap window insert <tab> <c-n>
          unmap window insert <s-tab> <c-p>
      }

      # ---------------------------------------------------------------------
      # Snippets: jdtls (and other servers) expose template completions
      # (sout, souf, psvm, ...) as regular LSP completions with
      # java.completion.enableSnippets = true (home/programs/kakoune/languages.nix,
      # same as Helix) - accepting one via Tab above already inserts it.
      # For a snippet with more than one tabstop, jump to the next one with
      # <a-tab> (deliberately not Tab itself - that's already claimed above
      # for completion-menu selection, and re-purposing it here would need
      # it to fall through to a real indent insert when there's no snippet
      # active, which risks recursing into its own mapping).
      # ---------------------------------------------------------------------
      map global insert <a-tab> ': lsp-snippets-select-next-placeholders<ret>' -docstring 'next snippet placeholder'

      # ---------------------------------------------------------------------
      # Leader key: Kakoune's builtin "user" mode is already entered with
      # <space> by default, exactly matching Helix's <space> menu
      # (docs.helix-editor.com/keymap.html) - just populate it.
      # ---------------------------------------------------------------------
      map global user k ': lsp-hover<ret>'            -docstring 'hover / show documentation'
      map global user r ': lsp-rename-prompt<ret>'    -docstring 'rename symbol'
      map global user a ': lsp-code-actions<ret>'     -docstring 'code action'
      map global user s ': lsp-document-symbol<ret>'  -docstring 'document symbols'
      # fzf-kak lazily defines its commands behind require-module. Each
      # submodule's generated kak code calls the base `fzf` picker command,
      # which only exists once the parent "fzf" module (not just the
      # submodule) is required too - mirrors what fzf.kak's own "fzf"
      # user-mode does internally on ModuleLoaded.
      map global user f ': require-module fzf; require-module fzf-file; fzf-file<ret>'     -docstring 'file picker'
      map global user b ': require-module fzf; require-module fzf-buffer; fzf-buffer<ret>' -docstring 'buffer picker'
      map global user g ': require-module fzf; require-module fzf-grep; fzf-grep<ret>'     -docstring 'grep / global search'
      map global user e ': filetree-switch-or-start<ret>' -docstring 'file tree (occivink/kakoune-filetree)'
      map global user i ': lsp-inlay-hints-toggle<ret>'    -docstring 'toggle inlay hints'
      # Kakoune's goto-mode already owns lowercase "i" (goto non-blank line
      # start) by default, so "goto implementation" lives here instead of
      # alongside gd/gr/gy below.
      map global user I ': lsp-implementation<ret>'       -docstring 'goto implementation'

      # gd / gr / gy, matching Helix's goto-definition/references/type-definition.
      # Kakoune's goto-mode already defines h/l/i/g/k/j/e/t/c/b/a/f/. - d/r/y are free.
      map global goto d ': lsp-definition<ret>'      -docstring 'goto definition'
      map global goto r ': lsp-references<ret>'      -docstring 'goto references'
      map global goto y ': lsp-type-definition<ret>' -docstring 'goto type definition'
    '';
  };
}
