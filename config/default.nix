{ inputs, pkgs, ... }: {

  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware.nix

    ../pkgs/common.nix
    ../nixos/desktop/kde.nix
    ../nixos/network/tailscale.nix
    ../nixos/virtualisation/podman.nix
    ../nixos/virtualisation/libvirt.nix
  ];

  # Enable zram
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    plymouth.enable = true;

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Networking
  networking = {
    hostName = "defiant";
    hostId = "c653d30b";
    domain = "serenity.lan";
    networkmanager.enable = true;
  };

  # Enable ZSH
  programs.zsh.enable = true;

  # Users
  users.users.craig = {
    isNormalUser = true;
    description = "Craig";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
    ];
  };

  # Welcome message
  programs.zsh.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" defiant";
}
