# My shell configuration
{
  pkgs,
  lib,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    nautilus
    nautilus-open-any-terminal
  ];
}
