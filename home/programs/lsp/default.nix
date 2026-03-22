{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash-language-server
    vscode-langservers-extracted
    docker-language-server
    typescript-language-server
    gopls
    graphql-language-service-cli
    jq-lsp
    texlab
    lua-language-server
    markdown-oxide
    mesonlsp
    rust-analyzer
    basedpyright
    svelte-language-server
    zls
    biome
  ];
}
