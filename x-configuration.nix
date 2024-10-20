{ pkgs, lib, ... }: 

{
   #Open ports for KDE Connect
   networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
   networking.firewall.allowedUDPPortRanges = [ { from = 1717; to = 1764; } ];
  
   # Enable touchpad support.
   services.libinput.enable = true;
 
   # Enable the X11 windowing system.
   # services.xserver.enable = true;
   # services.xserver.desktopManager.plasma5.enable = true; 

   # Use Plasma 6 w/ Wayland
   services.displayManager.defaultSession = "plasma";
   services.displayManager.sddm.enable = true;
   services.displayManager.sddm.theme = "breeze";
   services.displayManager.sddm.wayland.enable = true;
   services.displayManager.sddm.wayland.compositor = lib.mkForce "kwin";
   services.desktopManager.plasma6.enable = true;
   services.desktopManager.plasma6.enableQt5Integration = false;
 
   # Window Manager
   # programs.sway.enable = true;
   # programs.sway.wrapperFeatures.gtk = true;
   programs.hyprland.enable = true;
   programs.hyprland.xwayland.enable = true;
   
   programs.dconf.enable = true;
 
   environment.sessionVariables = {
    KWIN_COMPOSE = "O2";
    KWIN_OPENGL_INTERFACE = "egl"; 
    NIXOS_OZONE_WL = "1";
   };
 
   # Keyboard settings on X
   services.xserver.xkb.layout = "br";
   services.xserver.xkb.variant = "abnt2";
 
   # Video backwards compatibility 
   hardware.opengl.driSupport32Bit = true;

   # Scanner settings
   services.ipp-usb.enable = true;
   hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
   hardware.sane.brscan5 ={
     enable = true; 
     netDevices = {
       "MFP M130fw@CDQ/EscritÃrio" = { model = "MFP M130fw"; ip = "192.168.0.13"; };
       "SL-M4070FR@Adufms/Jornalismo" = { model = "SL-M4070FR"; ip = "192.168.0.150"; };
     };
   };
   # Online acoounts integration
   security.pam.services.sddm.enableKwallet = true;

   environment.variables.SSO_PLUGINS_DIR = ["/run/current-system/sw/lib/signon"];
   environment.variables.SSO_EXTENSIONS_DIR = ["/run/current-system/sw/lib/signon/extensions"];
   
   nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;
   programs.kdeconnect.enable = true;
   programs.chromium.enable = true;
   # programs.firefox.enable = true;   
   # programs.firefox.package = [ ]; -----------------------> IMPLEMENTAR

   # Fonts Settings.   
   fonts.fontDir.enable = true;
   fonts.enableDefaultPackages = true;
   fonts.enableGhostscriptFonts = true;
   fonts.fontconfig.enable = true;
   fonts.packages = with pkgs;
    [ dina-font
      fira-code
      fira-code-symbols
      font-awesome 
      freefont_ttf 
      gentium 
      inconsolata
      liberation_ttf 
      liberation-sans-narrow 
      libertine
      # mplus-outline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      open-sans 
      proggyfonts
      source-code-pro  
      symbola 
      ttf_bitstream_vera 
      ubuntu_font_family 
      unifont 
      ibm-plex
    ];
   
   #  Define how gpg will deal with pinentry" 
   programs.gnupg.agent = {
     enable = true;
     pinentryPackage = lib.mkForce pkgs.pinentry-qt;
   };

   # User packages for graphic environment.
   environment.systemPackages = with pkgs; with qt6; with libsForQt5; 
    [ kdePackages.plasma-desktop 
      wayland-utils
      kdePackages.kconfig
      # kdePackages.kconfig-frontends
      kdePackages.kpeople
      kdePackages.wayland
      kdePackages.zanshin
      kdePackages.skanlite
      kdeFrameworks.kactivities
      kdeFrameworks.kactivities-stats
      # Password manager for KDE
      kdeFrameworks.kwallet 
      kdeFrameworks.kcmutils
      kdeFrameworks.kconfigwidgets
      kdeFrameworks.kio
      kdeFrameworks.kconfig      
      kdeFrameworks.bluez-qt
      kdeFrameworks.plasma-framework
      # This is needed for graphical dialogs used to enter GPG passphrases
      kdeplasma-addons
      
      # Plasma System Settings 
      kdePackages.systemsettings
      kdePackages.libkscreen
      kdePackages.kdecoration
      khotkeys
      kdePackages.libksysguard	
      kdePackages.plasma-nm
      kdePackages.plasma-pa
      polkit-kde-agent
      kdePackages.powerdevil
      kdePackages.sddm-kcm
      plasma-browser-integration
      plasma-integration
      plasma-desktop
      plasma-workspace
      libsForQt5.ksystemlog      
      libsForQt5.plasma-browser-integration
      xwaylandvideobridge
      glxinfo
      vulkan-tools
      playerctl
      wayland-utils
      aha

      # Screenshots
      kdeApplications.spectacle
      kdeApplications.kwalletmanager
      # Printing and scanning
      kdeApplications.print-manager
      kdeApplications.dolphin-plugins
      kdeApplications.kio-extras
      kdeApplications.knotes
      # Desktop sharing tool
      kdeApplications.krfb              
      kdeApplications.kaccounts-providers   
      kdeApplications.kaccounts-integration
      # kdeApplications.signon-kwallet-extension # 20230213 Missing
      kdeApplications.calendarsupport
      kdeApplications.eventviews
      kdeApplications.kcalutils

      # KDE apps
      kinfocenter
      kscreen
      konsole
      kcalc
      kfind
      kwalletcli
      # Allow automatic unlocking of kwallet if the same password. This seems to work without installing kwallet-pam.
      kwallet-pam
      # ssh-add prompts a user for a passphrase using KDE. Not sure if it is used by anything? ssh-add just asks passphrase on the console.
      ksshaskpass
      # GPG manager for KDE
      kgpg
      # Text editor
      kate
      # Archives (e.g., tar.gz and zip)
      ark
      # Browsers
      chromium
      dolphin
      # Office Suit
      libreoffice
      # Spell checker 
      sonnet
      	aspellDicts.en
      	aspellDicts.es
      	aspellDicts.fr
      	aspellDicts.pt_BR
      # Document readers
      okular
      # Media player
      pacman
      unrar
      # Player de Video
      vlc
      # PDF Handler
      pdfsam-basic

      kio-gdrive    
      signond                     
      xdg-desktop-portal-kde
      qoauth
      #gdrivefs
      aha
    ];
  }
