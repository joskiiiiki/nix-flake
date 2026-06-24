# Zathura is a PDF viewer
{
  programs.zathura = {
    enable = true;

    options = {

      synctex = true;
      synctex-edit-command = "nvim --headless -c \"VimtexInverseSearch %{line} '%{input}'\"";
      guioptions = "v";
      adjust-open = "width";
      statusbar-basename = true;
      render-loading = false;
      scroll-step = 120;
    };
  };
}
