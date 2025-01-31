{ pkgs, ... }: {

  imports = [
    ../graphics/xserver.nix
    ../graphics/intel.nix

    ./pipewire.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./fonts.nix
  ];

  # KDE 6
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # KDE Partition Manager
  programs = {
    partition-manager.enable = true;
  };

  # Use the correct file picker on KDE
  programs.firefox.preferences = {
    "widget.use-xdg-desktop-portal.file-picker" = 1;
  };

  # Useful KDE packages
  environment.systemPackages = with pkgs; [
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.filelight
    onlyoffice-desktopeditors
  ];

  # Install a web browser
  programs.firefox.enable = true;
}
