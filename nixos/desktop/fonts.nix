{pkgs, ...}: {

  # Fonts
  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "bgr";
      subpixel.lcdfilter = "legacy";
      hinting.style = "full";
    };

    packages = with pkgs; [
      recursive
      atkinson-hyperlegible
      cascadia-code
      ia-writer-quattro
      ia-writer-duospace
      overpass
      rubik
      corefonts
      vistafonts
      nerdfonts
    ];
  };
}
