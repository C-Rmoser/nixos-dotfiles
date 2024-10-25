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
    ".config/hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
    ".config/waybar/style.css".source = ./waybar/style.css;
    "nixos/assets".source = ./assets;
    "_ideavimrc".source = ./intellij/_ideavimrc;
    # "nixos/assets/wlogout".source = ./assets/wlogout;
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
    syntaxHighlighting.enable = true;
    shellAliases = {
      nixconfig = "cd ~/.dotfiles && nvim ~/.dotfiles/configuration.nix";
      nixrebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles/";
      hconfig = "cd ~/.dotfiles && nvim ~/.dotfiles/home.nix";
      hrebuild = "home-manager switch --flake ~/.dotfiles/";
      wbconfig = "cd ~/.dotfiles/waybar && nvim ~/.dotfiles/waybar/style.css";
      nvimconfig = "cd ~/.dotfiles/nvim && nvim ~/.dotfiles/nvim/remap.lua";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "z"
        "git"
      ];
    };
    initExtra = ''
      # if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      #   exec tmux new-session -A -s default
      # fi
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };

  # Tmux
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    prefix = "C-Space";
    baseIndex = 1;
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set-option -sa terminal-features ',xterm-kitty:RGB'

      set -g status on
      set -g status-position top
      set-option -g status-style bg=default

      setw -g window-status-style 'fg=white bg=default'
      setw -g window-status-format ' #I#[fg=white]:#[fg=white]#W '
      setw -g window-status-current-style 'fg=#302d28 bg=#A7C080 bold'
      setw -g window-status-current-format ' #I#[fg=default]:#[fg=default]#W #[fg=#A7C080,bg=#302d28] '

      set -g status-right ""
      set -g status-left ""

      set -sg escape-time 0
    
      bind -n M-h select-pane -L
      bind -n M-l select-pane -R
      bind -n M-k select-pane -U
      bind -n M-j select-pane -D

      bind-key h split-window -v -c "#{pane_current_path}"
      bind-key v split-window -h -c "#{pane_current_path}"

      bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded."
    '';
  };

  # Ripgrep
  programs.ripgrep = {
    enable = true;
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
    # Lsp Zero
    {
      plugin = lsp-zero-nvim;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_lsp.lua);
    }
    {
      plugin = nvim-lspconfig;
    }
    {
      plugin = nvim-cmp;
    }
    {
      plugin = cmp-nvim-lsp;
    }
    {
      plugin = luasnip;
    }
    {
      plugin = tmux-navigator;
    }
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
      plugin = lualine-nvim;
      type = "lua";
      config = "require('lualine').setup()";
    }
    {
      plugin = comment-nvim;
      type = "lua";
      config = "require('Comment').setup()";
    }
    {
      plugin = nvim-surround;
      type = "lua";
      config = "require('nvim-surround').setup()";
    }
    {
      plugin = comment-nvim;
      type = "lua";
      config = "require('Comment').setup()";
    }
    {
      plugin = gitsigns-nvim;
      type = "lua";
      config = "require('gitsigns').setup()";
    }
    {
      plugin = nvim-web-devicons;
      type = "lua";
      config = "require('nvim-web-devicons').setup()";
    }
    {
      plugin = neoscroll-nvim;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_neoscroll-nvim.lua);
    }
    {
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_telescope.lua);
    }
    {
      plugin = nvim-tree-lua;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_nvim-tree.lua);
    }
    {
      plugin = telekasten-nvim;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_telekasten-nvim.lua);
    }
      telescope-ui-select-nvim
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = builtins.readFile(./nvim/plugin/_treesitter.lua);
    }
      plenary-nvim
      neodev-nvim
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./nvim/set.lua}
      ${builtins.readFile ./nvim/remap.lua}
      ${builtins.readFile ./nvim/globals.lua}
      vim.opt.rtp:append('/home/chris/code/neovim-plugins/stackmap.nvim')
    '';
  };

  wayland.windowManager.hyprland = {
    extraConfig = ''
      exec-once = hyprpaper
      exec-once = waybar
      exec-once = hyprctl dispatch workspace 1
    '';
    settings = {
      "$mod" = "SUPER";
      input = {
        kb_layout = "us,de";
        kb_options = "grp:win_space_toggle";
      };
      workspace = [
        # DP-1
        "1,monitor:DP-1,default:true,persistent:true"
        "2,monitor:DP-1,persistent:true"
        "3,monitor:DP-1,persistent:true"
        "4,monitor:DP-1,persistent:true"
        "5,monitor:DP-1,persistent:true"

        # DP-2
        "1,monitor:DP-2,default:true,persistent:true"
        "2,monitor:DP-2,persistent:true"
        "3,monitor:DP-2,persistent:true"
        "4,monitor:DP-2,persistent:true"
        "5,monitor:DP-2,persistent:true"
        "6,monitor:HDMI-A-2,default:true,persistent:true"
      ];
      monitor = [
        "DP-1,2560x1440@75,1920x0, 1"
        "DP-2,3440x1440@100,1920x0, 1"
        "HDMI-A-1,1920x1080@60,0x0, 1"
        "HDMI-A-2,1920x1080@60,0x0, 1"
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
          "$mod, B, exec, vivaldi"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, V, togglesplit"
          "$mod, S, exec, rofi -show drun -show-icons"
          "$mod, F, fullscreen"
          "$mod, T, swapnext"
          "$mod SHIFT, L, exec, wlogout"
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
      settings = {
        mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            output = [
              "DP-1"
              "DP-2"
              "HDMI-A-2"
            ];
            modules-left = [ "wlr/taskbar" ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [ "wireplumber" "battery" "bluetooth" "network" "cpu" "memory" "clock" "custom/power" ];

            network = {
              format = "{ifname}";
              format-ethernet = "eth 󰊗";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-disconnected = "";
            };

            clock = {
              format = "{:%H:%M}";
              tooltip-format = "{:%d.%m.%Y}";
            };

            wireplumber = {
              format = "{volume}% {icon}";
              format-icons = ["" "" ""];
              format-muted = "";
              on-click = "helvum";
              max-volume = 150;
              scroll-step = 1;
            };

            cpu = {
              format = "{}% ";
            };

            memory = {
              format = "{}% ";
            };

            bluetooth = {
              format = "{num_connections} ";
              format-disabled = "";
              format-off = "";
              interval = "30";
              on-click = "blueman-manager";
              format-no-controller = "";
            };

            "custom/power" = {
                format = "⏻";
                tooltip = false;
                on-click = "sleep 0.1 && wlogout --protocol layer-shell";
            };

            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
              format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                "urgent" = "";
                "default" = "";
              };
              "persistent-workspaces" = {
                "0" = ["DP-2"];
                "1" = ["DP-2"];
                "2" = ["DP-2"];
                "3" = ["DP-2"];
                "4" = ["DP-2"];
                "5" = ["DP-2"];
                "6" = ["HDMI-A-2"];
              };
              sort-by-number = true;
            };
          };
    };
  };

  programs.wlogout = {
    enable = true;

    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "sleep 1; hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];

    style = ''
      * {
        background-image: none;
        box-shadow: none;
      }

      window {
        background-color: rgba(22, 22, 22, 0.8);
      }

      button {
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        background-color: rgba(22, 22, 22, 0.8);
        margin: 20;
        border: 1px solid #45707a;
        color: #d4be98;
        text-decoration-color: red;
      }

      button:focus {
        background-color: #45707a;
      }

      #lock {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/lock.png");
      }
      
      #hibernate {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/hibernate.png");
      }

      #logout {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/logout.png");
      }

      #shutdown {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/shutdown.png");
      }

      #suspend {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/suspend.png");
      }
      
      #reboot {
        background-image: url("${config.home.homeDirectory}/nixos/assets/wlogout/reboot.png");
      }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
