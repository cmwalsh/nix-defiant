{ pkgs, ... }: {

  services.xserver = {
    enable = true;

    # X11 keymap
    xkb = {
      layout = "gb";
      variant = "";
    };

    # Disable xterm
    excludePackages = [pkgs.xterm];
    desktopManager.xterm.enable = false;
  };
}
