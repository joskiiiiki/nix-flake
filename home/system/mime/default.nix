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
      "image/png" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/jpg" = "org.gnome.Loupe.desktop";
      "image/webp" = "org.gnome.Loupe.desktop";
      "image/gif" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "text/html" = "vivaldi-stable.desktop";
      "application/pdf" = "org.gnome.Papers.desktop";

      # Word
      "application/msword" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop";

      # PowerPoint
      "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop";

      # Excel
      "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop";
    };
  };
}
