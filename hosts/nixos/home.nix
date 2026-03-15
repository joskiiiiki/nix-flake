{ pkgs, config, inputs, ... }: {

  imports = [
    ./variables.nix

    ../../shared/home.nix

    # Scripts

    # ./secrets # CHANGEME: You should probably remove this line, this is where I store my secrets
  ];
}
