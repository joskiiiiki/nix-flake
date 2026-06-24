# Mime allows us to configure the default applications for each file type
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/markdown" = "helix.desktop";
      "text/plain" = "helix.desktop";
      "text/x-shellscript" = "helix.desktop";
      "text/x-python" = "helix.desktop";
      "text/x-go" = "helix.desktop";
      "text/css" = "helix.desktop";
      "text/javascript" = "helix.desktop";
      "text/x-c" = "helix.desktop";
      "text/x-c++" = "helix.desktop";
      "text/x-java" = "helix.desktop";
      "text/x-rust" = "helix.desktop";
      "text/x-yaml" = "helix.desktop";
      "text/x-toml" = "helix.desktop";
      "text/x-dockerfile" = "helix.desktop";
      "text/x-xml" = "helix.desktop";
      "text/x-php" = "helix.desktop";
      "image/png" = "loupe.desktop";
      "image/jpeg" = "loupe.desktop";
      "image/jpg" = "loupe.desktop";
      "image/webp" = "loupe.desktop";
      "image/gif" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "text/html" = "zen.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
    };
  };
}
