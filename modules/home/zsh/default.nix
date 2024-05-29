{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.mgnix.apps.zsh;
in {
  options.mgnix.apps.zsh = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    wslIntegration = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [bash];

      programs.zsh = {
        enable = true;

        autocd = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        historySubstringSearch.enable = true;

        history = {
          size = 1000;
          save = 500;
        };

        defaultKeymap = "emacs";

        shellAliases = {
          zz = "z -"; # Toggle last directory via zoxide
        };

        plugins = [
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.5.0";
              sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
            };
          }
        ];

        initExtraFirst = ''
          if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then . "$HOME/.nix-profile/etc/profile.d/nix.sh"; fi
        '';

        initExtraBeforeCompInit = ''
          zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
          zstyle ':completion:*' rehash true                              # automatically find new executables in path
          # Speed up completions
          zstyle ':completion:*' accept-exact '*(N)'
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path ~/.zsh/cache
        '';

        initExtra = mkMerge [
          ''
            ## Options section
            setopt correct                                                  # Auto correct mistakes
            setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
            setopt nocaseglob                                               # Case insensitive globbing
            setopt rcexpandparam                                            # Array expension with parameters
            setopt nocheckjobs                                              # Don't warn about running processes when exiting
            setopt numericglobsort                                          # Sort filenames numerically when it makes sense
            setopt nobeep                                                   # No beep
            setopt appendhistory                                            # Immediately append history instead of overwriting
            setopt histignorealldups                                        # If a new command is a duplicate, remove the older one

            # Don't consider certain characters part of the word
            WORDCHARS=''${WORDCHARS//\/[&.;]}

            if [ -e $HOME/.defaultapps ]; then
              source $HOME/.defaultapps
            fi

            bindkey '^[[1;5D' backward-word
            bindkey '^[[1;5C' forward-word
          ''

          (mkIf cfg.wslIntegration ''
            # Add Windows Path, if run in WSL
            if uname -r | grep -q 'microsoft'; then
              export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows/SysWOW64/:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"

              # pbcopy/pbpaste function to copy into system clipboard
              function pbcopy() {
                  printf $(</dev/stdin) | clip.exe
              }

              function pbpaste() {
                pwsh.exe -NoProfile -NonInteractive -Command Get-Clipboard 2>/dev/null | sed 's/\r$//' | sed '$ s/\n$//'
              }
            fi
          '')

          ''
            export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
          ''
        ];
      };
    }
  ]);
}
