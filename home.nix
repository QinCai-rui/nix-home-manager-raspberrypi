{
  config,
  pkgs,
  ...
}: let
  unstablePkgs = import <nixpkgs> {};
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "qincai";
  home.homeDirectory = "/home/qincai";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  #nix.package = pkgs.nix;
  
  # Use nix from nix-unstable
  nix.package = unstablePkgs.nix;
#  nix.settings.experimental-features = ["nix-command" "flakes"];
  targets.genericLinux.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with unstablePkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Start System Tools
    btop
    tree
    ncdu
    fastfetch
    iotop
    wavemon
#    nvtop
#    pbzip2
    # End System Tools

    # Start Nix Specific
    nix-output-monitor
#    alejandra
#    nh            #off for now (couldn't get non-flake working)
    # End Nix Specific

    # Start Server Software
#    tailscale
#    cloudflared
    bun
    #docker	# off for now (couln't get it working as systemd service)
#    sshx
    croc
#    nodejs_23
    # End Server Software

    # Start Version Control
    gh
    git
    # End Version Control

    # Start Local ML
#    ollama
    # End Local ML

    # Start Other
#    clang
#    sysbench
#    geekbench
    ookla-speedtest
    stress
#    stress-ng
#    s-tui
#    fish
    util-linux
    # End Other
  ];

  programs.bash = {
    enable = true;
    #    bashrcExtra = "${config.home.homeDirectory}/.config/home-manager/.bashrc.old";
    initExtra = "source ${config.home.homeDirectory}/.config/home-manager/.bashrc.old && source ${config.home.homeDirectory}/.ps1";
  };

  programs.bash.shellAliases = {
    # Start Custom
    "ncdu" = "ncdu -2 --color=dark-bg";
    "sudo" = "sudo env PATH=$PATH";
    "hm-rebuild" = "home-manager switch |& nom";
    "hm-edit" = "home-manager edit";
    "nix-update" = "nix-channel --update -vvv";
    "pihole" = "docker exec -it pihole pihole";
    "deb" = "nala";

    # End Custom

    # Start RPi OS
    "ls" = "ls --color=auto";
    "grep" = "grep --color=auto";
    "fgrep" = "fgrep --color=auto";
    "egrep" = "egrep --color=auto";

    "ll" = "ls -l";
    "la" = "ls -A";
    "l" = "ls -CF";
    # End RPi OS

    # Start Docker Compose
    "docker-compose" = "docker compose";
    # End Docker Compose
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/qincai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nano";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
