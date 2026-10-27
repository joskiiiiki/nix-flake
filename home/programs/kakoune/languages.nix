{ pkgs, ... }:
{
  # kak-lsp already ships sane `lsp-filetype-*` default hooks for most
  # languages (java -> jdtls, rust -> rust-analyzer, css/html -> vscode-*,
  # etc, see `kak-lsp --kakoune`). These hooks run in the *same* `filetype`
  # BufSetOption group, registered after kak-lsp's own, so `set-option
  # buffer lsp_servers` here simply overwrites the default and wins -
  # mirroring the server choices made in home/programs/helix/languages.nix.
  #
  # Each per-language BufSetOption hook registers its own format-on-save
  # hook with `buffer` scope (not `global`!) from inside itself, so it only
  # ever fires for buffers whose filetype actually matched - a `global`
  # BufWritePre hook has no filetype filter and fires on *every* buffer
  # write, including scratch/fifo buffers that never got `formatcmd` set.
  programs.kakoune.extraConfig = ''
    # --- filetype detection for languages Kakoune doesn't ship rc/filetype/*.kak for ---
    hook global BufCreate .*\.wgsl %{ set-option buffer filetype wgsl }
    hook global BufCreate (.*/)?nginx.*\.conf %{ set-option buffer filetype nginx }
    hook global BufCreate (.*/)?(Caddyfile|.*\.caddy) %{ set-option buffer filetype caddyfile }

    # --- python: ty + ruff, like Helix (instead of kak-lsp's default pylsp) ---
    # ty-direnv/ruff-direnv (home/programs/lsp/default.nix) re-run these
    # through `direnv exec` for the buffer's project dir, so a flake/venv
    # interpreter is actually visible to the server instead of the ambient
    # system Python.
    hook -group lsp-filetype-python global BufSetOption filetype=python %{
        set-option buffer lsp_servers %{
            [ty]
            command = "ty-direnv"
            args = ["server"]
            root_globs = ["pyproject.toml", "setup.py", "poetry.lock", ".git"]

            [ruff]
            command = "ruff-direnv"
            args = ["server"]
            root_globs = ["pyproject.toml", "setup.py", "poetry.lock", ".git"]
        }
        set-option buffer formatcmd "${pkgs.ruff}/bin/ruff format -"
        hook -group lsp-filetype-python buffer BufWritePre .* format-buffer
    }

    # --- typescript/tsx/javascript: typescript-language-server + biome + tailwindcss ---
    hook -group lsp-filetype-javascript global BufSetOption filetype=(?:javascript|typescript) %{
        set-option buffer lsp_servers %{
            [typescript-language-server]
            root_globs = ["package.json", "tsconfig.json", "jsconfig.json", ".git"]
            args = ["--stdio"]

            [biome]
            root_globs = ["package.json", "biome.json", ".git"]
            args = ["lsp-proxy"]

            [tailwindcss-language-server]
            root_globs = ["tailwind.config.js", "tailwind.config.ts", "package.json", ".git"]
            args = ["--stdio"]
        }
        set-option buffer formatcmd "${pkgs.biome}/bin/biome format --stdin-file-path file.ts"
        hook -group lsp-filetype-javascript buffer BufWritePre .* format-buffer
    }

    # --- html: vscode-html-language-server + tailwindcss ---
    hook -group lsp-filetype-html global BufSetOption filetype=html %{
        set-option buffer lsp_servers %{
            [vscode-html-language-server]
            root_globs = ["package.json", ".git"]
            args = ["--stdio"]
            settings_section = "_"
            [vscode-html-language-server.settings._]
            provideFormatter = true

            [tailwindcss-language-server]
            root_globs = ["tailwind.config.js", "tailwind.config.ts", "package.json", ".git"]
            args = ["--stdio"]
        }
        hook -group lsp-filetype-html buffer BufWritePre .* %{ try %{ lsp-formatting-sync } }
    }

    # --- css: vscode-css-language-server + tailwindcss ---
    hook -group lsp-filetype-css global BufSetOption filetype=(?:css|less|scss) %{
        set-option buffer lsp_servers %{
            [vscode-css-language-server]
            root_globs = ["package.json", ".git"]
            args = ["--stdio"]
            settings_section = "_"
            [vscode-css-language-server.settings._]
            provideFormatter = true

            [tailwindcss-language-server]
            root_globs = ["tailwind.config.js", "tailwind.config.ts", "package.json", ".git"]
            args = ["--stdio"]
        }
        hook -group lsp-filetype-css buffer BufWritePre .* %{ try %{ lsp-formatting-sync } }
    }

    # --- json: biome, matching Helix ---
    hook -group lsp-filetype-json global BufSetOption filetype=json %{
        set-option buffer lsp_servers %{
            [biome]
            root_globs = ["package.json", "biome.json", ".git"]
            args = ["lsp-proxy"]
        }
        set-option buffer formatcmd "${pkgs.biome}/bin/biome format --stdin-file-path file.json"
        hook -group lsp-filetype-json buffer BufWritePre .* format-buffer
    }

    # --- java: jdtls, same settings as Helix/Zed (home/programs/helix/languages.nix) ---
    hook -group lsp-filetype-java global BufSetOption filetype=java %{
        set-option buffer lsp_servers %{
            [jdtls]
            command = "jdtls-launcher"
            root_globs = ["pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle", "settings.gradle.kts", ".git"]
            settings_section = "_"
            workspace_did_change_configuration_subsection = "settings"
            [jdtls.settings._.settings.java.completion]
            enableSnippets = true
            [jdtls.settings._.settings.java.import.gradle]
            enabled = true
            [jdtls.settings._.settings.java.import.maven]
            enabled = true
            [jdtls.settings._.settings.java.configuration]
            updateBuildConfiguration = "automatic"
            [[jdtls.settings._.settings.java.configuration.runtimes]]
            name = "JavaSE-21"
            path = "${pkgs.jdk.home}"
            default = true
        }
    }

    # --- kotlin: kak-lsp has no default hook for this, add one ---
    hook -group lsp-filetype-kotlin global BufSetOption filetype=kotlin %{
        set-option buffer lsp_servers %{
            [kotlin-language-server]
            root_globs = ["settings.gradle.kts", "settings.gradle", "build.gradle.kts", "build.gradle", ".git"]
        }
    }

    # --- nginx: not covered by kak-lsp defaults ---
    hook -group lsp-filetype-nginx global BufSetOption filetype=nginx %{
        set-option buffer lsp_servers %{
            [nginx-language-server]
            root_globs = [".git"]
        }
        # nginxfmt isn't in nixpkgs (same gap as home/programs/helix/languages.nix -
        # it must be installed out-of-band for this formatter to work).
        set-option buffer formatcmd "nginxfmt -i 4 -"
        hook -group lsp-filetype-nginx buffer BufWritePre .* format-buffer
    }

    # --- wgsl: not covered by kak-lsp defaults ---
    hook -group lsp-filetype-wgsl global BufSetOption filetype=wgsl %{
        set-option buffer lsp_servers %{
            [wgsl-analyzer]
            root_globs = [".git"]
        }
        set-option buffer formatcmd "${pkgs.wgsl-analyzer}/bin/wgslfmt -"
        hook -group lsp-filetype-wgsl buffer BufWritePre .* format-buffer
    }

    # --- caddyfile: caddy-language-server isn't in nixpkgs either (same gap
    # as Helix's "caddy-lsp" entry) - wired for when it's installed out-of-band.
    hook -group lsp-filetype-caddyfile global BufSetOption filetype=caddyfile %{
        set-option buffer lsp_servers %{
            [caddy-language-server]
            args = ["--stdio"]
            root_globs = [".git"]
        }
        set-option buffer formatcmd "caddy fmt -"
        hook -group lsp-filetype-caddyfile buffer BufWritePre .* format-buffer
    }
  '';

  home.packages = with pkgs; [
    # ty/ruff (and their *-direnv wrappers) come from home/programs/lsp/default.nix
    biome
    typescript-language-server
    tailwindcss-language-server
    vscode-langservers-extracted
    kotlin-language-server
    nginx-language-server
    # jdt-language-server / jdtls-launcher come from home/programs/helix/default.nix;
    # both modules are imported by shared/home.nix so there's no duplicate install.
  ];
}
