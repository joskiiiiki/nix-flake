{lib, ...}:
final: prev:
{
  colors = import ./colors.nix {inherit lib final prev;};
}
