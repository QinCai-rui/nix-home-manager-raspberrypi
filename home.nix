{
  config,
  pkgs,
  ...
}: {
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
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
    pkgs.btop
    pkgs.ncdu
    pkgs.fastfetch
    pkgs.iotop
    pkgs.wavemon

    pkgs.pbzip2
    # End System Tools

    # Start Nix Specific
    pkgs.nix-output-monitor
    pkgs.alejandra
    #pkgs.nh            #off for now (couldn't get non-flake working)
    # End Nix Specific

    # Start Server Software
    pkgs.tailscale
    pkgs.cloudflared
    pkgs.bun
    #pkgs.docker	# off for now (couln't get it working as systemd service)
    pkgs.sshx
    # End Server Software

    # Start Version Control
    pkgs.gh
    pkgs.git
    # End Version Control

    # Start Local ML
    pkgs.ollama
    # End Local ML
  ];

  programs.bash = {
    enable = true;
    #    bashrcExtra = "${config.home.homeDirectory}/.bashrc.pios";
    initExtra = "source ${config.home.homeDirectory}/.bashrc.pios";
  };

  programs.bash.shellAliases = {
    # Start Custom
    "ncdu" = "ncdu -2 --color=dark-bg";
    "sudo" = "sudo env PATH=$PATH";
    "hm-rebuild" = "home-manager switch |& nom";
    "hm-edit" = "home-manager edit";
    "nix-update" = "nix-channel --update -vvv";
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
