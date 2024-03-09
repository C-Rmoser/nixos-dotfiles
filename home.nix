{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "chris";
  home.homeDirectory = "/home/chris";
            
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

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
  ];

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
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/chris/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Dark Medium";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = "14";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      enable_audio_bell = false; 
      background_opacity = "0.8";
    };
  };

  # ZSH
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      nixconfig = "nvim ~/.dotfiles/configuration.nix";
      nixrebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
      hconfig = "nvim ~/.dotfiles/home.nix";
      hrebuild = "home-manager switch --flake ~/.dotfiles/";
      ll = "ls -l";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "z"
        "git"
      ];
    };
  };

  programs.zsh.syntaxHighlighting.enable = true;

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
    {
      plugin = gruvbox-material;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_gruvbox-material.lua);
    }
    {
      plugin = bufferline-nvim;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_bufferline-nvim.lua);
    }
    {
      plugin = comment-nvim;
      type = "lua";
      config = "require('Comment').setup()";
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = "require('nvim-web-devicons').setup()";
    }
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/set.lua}
      ${builtins.readFile ./nvim/remap.lua}
    '';
  };

  wayland.windowManager.hyprland = {
    extraConfig = ''
      exec-once=swww init && swww img ~/Wallpapers/gruv-stairs.jpg
    '';
    settings = {
      "$mod" = "SUPER";
      monitor = [
        "HDMI-A-2,1920x1080@60,0x0, 1"
        "DP-2,3440x1440@100,1920x0, 1"
      ];
      general = {
        gaps_out = "10";
        gaps_in = "5";
        border_size = "2";
        "col.active_border" = "rgba(faca52aa) rgba(5fb4f5aa)";
        "col.inactive_border" = "rgba(595959aa)";
      };
      decoration = {
        rounding = 10;
        blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
        };
      };
      bind =
        [
          # Switch workspaces with mainMod + [0-9]
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          # Move focus with mainMod + arrow keys
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # Additional keybinds
          "$mod, Q, exec, kitty"
          "$mod, B, exec, brave"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, T, togglesplit"
          "$mod, S, exec, rofi -show drun -show-icons"
        ];
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
    };
  };

  programs.waybar = {
    enable = true;
    # settings = {
    # mainBar = {
    #  layer = "top";
    # };
    # };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
