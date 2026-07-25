{ lib, ... }: {
  programs.helix.settings = {
    theme = lib.mkForce "vercel";

    editor = {
      cursorline = true;
      bufferline = "multiple";
      popup-border = "all";
      end-of-line-diagnostics = "hint";
      default-yank-register = "+";

      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      file-picker = {
        hidden = false;
      };

      statusline = {
        left = [
          "mode"
          "spinner"
          "register"
        ];
        center = [
          "version-control"
          "file-name"
          "file-modification-indicator"
        ];
        right = [
          "diagnostics"
          "selections"
          "position"
          "file-encoding"
          "total-line-numbers"
          "file-line-ending"
          "file-type"
        ];
        separator = "│";

        mode = {
          normal = "NORMAL";
          insert = "INSERT";
          select = "SELECT";
        };
      };

      lsp = {
        display-inlay-hints = true;
      };

      auto-save = {
        focus-lost = true;
        after-delay = {
          enable = true;
        };
      };

      indent-guides = {
        render = true;
        character = "┆";
        skip-levels = 1;
      };

      gutters = {
        layout = [
          "diff"
          "diagnostics"
          "line-numbers"
          "spacer"
        ];
      };

      inline-diagnostics = {
        cursor-line = "warning";
        other-lines = "hint";
      };
    };

    keys = {
      insert = {
        "C-space" = "completion";
      };

      normal = {
        "A-ä" = "switch_to_uppercase";
        "C-space" = "completion";
        space = {
          i = ":toggle lsp.display-inlay-hints";
        };
      };

      
    };
  };
}
