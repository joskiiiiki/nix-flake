{ lib, ... }:
let
  hexToRgb =
    hex:
    let
      h = lib.removePrefix "#" hex;
    in
    {
      r = lib.fromHexString (builtins.substring 0 2 h);
      g = lib.fromHexString (builtins.substring 2 2 h);
      b = lib.fromHexString (builtins.substring 4 2 h);
    };
  rgbToHex =
    {
      r,
      g,
      b,
    }:
    let
      pad =
        s:
        let
          padLen = lib.max 0 (2 - (lib.stringLength s));
          padStr = lib.concatStrings (lib.replicate padLen "0");
        in
        padStr + s;
    in
    "${pad (lib.toLower (lib.toHexString r))}"
    + "${pad (lib.toLower (lib.toHexString g))}"
    + "${pad (lib.toLower (lib.toHexString b))}";

  darkenRgb =
    f:
    {
      r,
      g,
      b,
    }:
    {
      r = builtins.floor (r * f);
      g = builtins.floor (g * f);
      b = builtins.floor (b * f);
    };

  mixRgb =
    f: c1: c2:
    let
      mix = a: b: builtins.floor ((1 - f) * a + (f * b));
    in
    {
      r = mix c1.r c2.r;
      g = mix c1.g c2.g;
      b = mix c1.b c2.b;
    };

  darkenHex =
    hex: f:
    lib.pipe hex [
      hexToRgb
      (darkenRgb f)
      rgbToHex
    ];

  mixHex =
    f: hex1: hex2:
    rgbToHex (mixRgb f (hexToRgb hex1) (hexToRgb hex2));
in
{
  inherit
    hexToRgb
    rgbToHex
    darkenRgb
    mixRgb
    darkenHex
    mixHex
    ;
}
