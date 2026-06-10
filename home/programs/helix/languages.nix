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
      ruff = {
        command = "ruff";
        args = [ "server" ];
      };
      ty = {
        command = "ty";
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
    };
  };
}
