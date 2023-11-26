# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  
   boot.loader.grub.enable = true;
   boot.loader.grub.device = "nodev";
   boot.loader.grub.efiSupport = true;
   boot.loader.efi.canTouchEfiVariables = true;
   boot.loader.efi.efiSysMountPoint = "/boot";

   networking.hostName = "nixmain"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

#nixpkgs.config.packageOverrides = self : rec {
#    blender = self.blender.override {
#      cudaSupport = true;
#    };
#  };

virtualisation.libvirtd.enable = true;
programs.dconf.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.deadlock= {
     initialPassword= "SuperSecret1!";
     isNormalUser = true;
     extraGroups = [ "wheel" "media" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
	vim
     ];
   };


# enable the Open Tablet Driver
#hardware.opentabletdriver.enable = true; # it's shit.

# desktop config
services.xserver.enable = true; # is this really necessary with wayland?
services.xserver.displayManager.gdm.enable = true;
services.xserver.desktopManager.gnome.enable = true;

# locale config
i18n.defaultLocale = "en_US.utf8";
i18n.supportedLocales = ["all"];

# allow non-free software
nixpkgs.config.allowUnfree = true;
programs.kdeconnect = {
    enable = true;
    package = pkgs.gnomeExtensions.gsconnect;
};

# benis
# shitcord needs this override
nixpkgs.config.permittedInsecurePackages = [
                "electron-22.3.27"
              ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     librewolf
     firefox 
     protonmail-bridge
     krita
     gimp
     kdenlive
     steam
     discord
     appimage-run
     vscodium
     freetube
     qbittorrent
     vlc
     rhythmbox
     htop
     nvtop
     neofetch
     virt-manager
     libvirt
     lutris
     bottles
     libreoffice-fresh
     pureref
     joplin-desktop
     neovim
     python311
     retext
     python311Packages.anyqt
     jetbrains.idea-community
     mpv
     jetbrains.jdk
     transmission
     zig
     hugo
     git
     SDL2
     SDL2_mixer
     SDL2_image
     SDL2_ttf
     keepassxc
     wine
     wine64
     thunderbird
     winetricks
     wireshark
     dxvk
     pciutils
     gcc
     blender
     yt-dlp
     unzip
     dig
     traceroute
     nmap
     lm_sensors
     usbutils
     tcpdump
     cron
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
environment.sessionVariables = {
	NIXOS_OZONE_WL = "1";
};


programs.bash.shellAliases = {
  l = "ls -alh";
  ll = "ls -l";
  ls = "ls --color=tty";
  nixed = "sudo nvim /etc/nixos/configuration.nix";
  nixb = "sudo nixos-rebuild boot";
  nixu = "sudo nixos-rebuild boot --upgrade";
  nixs = "sudo nixos-rebuild switch";
  nixc = "sudo nix-collect-garbage -d";
};
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "nixos-23.05"; # Did you read the comment?

}

