{ pkgs, pkgs-unstable, ... }: {

  home = {
    username = "craig";
    homeDirectory = "/home/craig";
    stateVersion = "24.11";

    packages =
      (with pkgs; [
        # Dev
        nodejs_22
        pnpm
        vscode
        nixd
        nil
        nixpkgs-fmt

        # Multimedia
        ffmpeg-full
        lame
        mpv
        vdhcoapp
        spotify
        haruna
        gimp

        # Comms
        discord
        teams-for-linux
        mumble
        element-desktop

        # Productivity
        obsidian
        thunderbird-128
        google-chrome

        # Utility
        bitwarden
        ventoy
        vorta
        ktailctl

        # Shell
        zsh
        kitty
        starship

        # Sysadmin
        moonlight-qt

        # Overrides
        (callPackage ../pkgs/freeshow {})
      ])
      ++ (with pkgs-unstable; [
        # Dev
        deno
        zed-editor

        #Utilities
        cryptomator
        picocrypt
        picocrypt-cli
        ghostty
      ]);
  };

  # Enable home manager and target generic linux
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  # Setup connection to libvirt
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  # Git
  programs.git = {
    enable = true;
    userName = "Craig W";
    userEmail = "319043+cmwalsh@users.noreply.github.com";

    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
    };
  };

  # Kitty
  programs.kitty = {
    enable = true;
    themeFile = "Japanesque";
    shellIntegration.enableZshIntegration = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 12;
    };

    settings = {
      enable_audio_bell = false;
    };
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
      z = "zoxide";
    };

    sessionVariables = {
      EDITOR = "micro";
      VISUAL = "micro";
      PNPM_HOME = "/home/craig/.config/pnpm/global";
    };

    initExtra = ''
      # case insensitive path-completion
      autoload -U compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # Set the path for pnpm binaries
      path+=('/home/craig/.config/pnpm/global')

      # kitty ssh fix
      [[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
    '';
  };

  # Starship
  programs.starship = {
    enable = true;

    settings = {
      add_newline = true;
    };
  };
}
