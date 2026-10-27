{ pkgs, ... }:
{
  programs.helix.languages = {
    language = [
      {
        name = "nginx";
        language-servers = [ "nginx-language-server" ];
        formatter = {
          command = "nginxfmt";
          args = [
            "-i"
            "4"
            "-"
          ];
        };
      }
      {
        name = "wgsl";
        language-servers = [ "wgsl-analyzer" ];
        formatter = {
          command = "wgslfmt";
          args = [ "-" ];
        };
      }
      {
        name = "python";
        language-servers = [
          "ty"
          "ruff"
        ];
        formatter = {
          command = "ruff";
          args = [
            "format"
            "-"
          ];
        };
      }
      {
        name = "typescript";
        language-servers = [
          "typescript-language-server"
          "biome"
          "tailwindcss"
        ];
        auto-format = true;
        formatter = {
          command = "biome";
          args = [
            "format"
            "--stdin-file-path"
            "file.ts"
          ];
        };
      }
      {
        name = "tsx";
        language-servers = [
          "typescript-language-server"
          "biome"
          "tailwindcss"
        ];
        auto-format = true;
        formatter = {
          command = "biome";
          args = [
            "format"
            "--stdin-file-path"
            "file.tsx"
          ];
        };
      }
      {
        name = "javascript";
        language-servers = [
          "typescript-language-server"
          "biome"
          "tailwindcss"
        ];
        auto-format = true;
        formatter = {
          command = "biome";
          args = [
            "format"
            "--stdin-file-path"
            "file.js"
          ];
        };
      }
      {
        name = "html";
        language-servers = [
          "vscode-html-language-server"
          "tailwindcss"
        ];
        auto-format = true;
      }
      {
        name = "css";
        language-servers = [
          "vscode-css-language-server"
          "tailwindcss"
        ];
        auto-format = true;
      }
      {
        name = "json";
        language-servers = [ "biome" ];
        auto-format = true;
        formatter = {
          command = "biome";
          args = [
            "format"
            "--stdin-file-path"
            "file.json"
          ];
        };
      }
      {
        name = "java";
        scope = "source.java";
        injection-regex = "java";
        file-types = [ "java" ];
        roots = [
          "pom.xml"
          "build.gradle"
          "build.gradle.kts"
          "settings.gradle"
          "settings.gradle.kts"
          ".git"
        ];
        language-servers = [ "jdtls" ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
      {
        name = "kotlin";
        roots = [
          "settings.gradle.kts"
          "settings.gradle"
          "build.gradle.kts"
          "build.gradle"
          ".git"
        ];
        language-servers = [ "kotlin-language-server" ];
      }
      {
        name = "caddyfile";
        language-servers = [ "caddy-lsp" ];
        auto-format = true;
        formatter = {
          command = "caddy";
          args = [
            "fmt"
            "-"
          ];
        };
      }
    ];
    language-server = {
      nginx-language-server = {
        command = "nginx-language-server";
        args = [ ];
      };
      wgsl-analyzer = {
        command = "wgsl-analyzer";
        args = [ ];
      };
      # *-direnv wrappers (home/programs/lsp/default.nix) re-run these through
      # `direnv exec` for the buffer's project dir, so a flake/venv-managed
      # interpreter (numpy, etc.) is actually visible to the server - plain
      # `ruff`/`ty` here would otherwise resolve the ambient system Python.
      ruff = {
        command = "ruff-direnv";
        args = [ "server" ];
      };
      ty = {
        command = "ty-direnv";
        args = [ "server" ];
      };
      biome = {
        command = "biome";
        args = [ "lsp-proxy" ];
      };
      tailwindcss = {
        command = "tailwindcss-language-server";
        args = [ "--stdio" ];
      };
      caddy-lsp = {
        command = "caddy-language-server";
        args = [ "--stdio" ];
      };
      jdtls = {
        command = "jdtls-launcher";
        config = {
          java = {
            completion = {
              enableSnippets = true;
            };
            import = {
              gradle = {
                enabled = true;
              };
              maven = {
                enabled = true;
              };
            };
            configuration = {
              updateBuildConfiguration = "automatic";
              runtimes = [
                {
                  name = "JavaSE-21";
                  path = "${pkgs.jdk.home}";
                  default = true;
                }
              ];
            };
            inlayHints = {
              parameterNames = {
                enabled = "all";
              };
            };
          };
        };
      };
      kotlin-language-server = {
        command = "kotlin-language-server";
      };
    };
  };
}
