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

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    # Enable OpenCL
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
