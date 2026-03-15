{
  services.fprintd.enable = true;
  security.pam.services = {
    greetd.fprintAuth = true;
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
  };
}
