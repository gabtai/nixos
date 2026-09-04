{ config, pkgs, ... }:

{
  # Enable Zsh 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    histSize = 10000;
    promptInit = "";

    # Aliasok a kényelmes napi használathoz
    shellAliases = {
      # Alapvető parancsok felülírása és színek
      ls = "ls -hN --color=auto --group-directories-first";
      grep = "grep --color=auto";
      diff = "diff --color=auto";

      # Biztonsági / Gyorsító opciók
      ka = "killall";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";

      # NixOS és Flake parancsok
      rebuild = "doas nixos-rebuild switch --flake /etc/nixos#nixos";
      up = "nix flake update --flake /etc/nixos && doas nixos-rebuild switch --flake /etc/nixos#nixos";
      gc = "doas nix-collect-garbage -d && doas nixos-rebuild switch --flake /etc/nixos#nixos";

    };

    # Egyedi kiegészítések és a saját prompt / funkcióid behívása
    interactiveShellInit = ''
      # --- Színes MAN oldalak ---
      export LESS_TERMCAP_mb=$'\e[1;31m'
      export LESS_TERMCAP_md=$'\e[1;36m'
      export LESS_TERMCAP_me=$'\e[0m'
      export LESS_TERMCAP_so=$'\e[01;33m'
      export LESS_TERMCAP_se=$'\e[0m'
      export LESS_TERMCAP_us=$'\e[1;4;32m'
      export LESS_TERMCAP_ue=$'\e[0m'

      # Zsh opciók
      setopt SHARE_HISTORY
      setopt APPEND_HISTORY
      setopt INTERACTIVE_COMMENTS 

      # Kiegészítési stílusok
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' menu select

      # --- Pure Prompt + Async Betöltése ---
      fpath=(${pkgs.pure-prompt}/share/zsh/site-functions $fpath)
      autoload -Uz promptinit && promptinit
      prompt pure
    '';
  };

  # Set Zsh as login shell for user
  users.users.gabtai.shell = pkgs.zsh;

  # Segédprogramok a Zsh mellé
  environment.systemPackages = with pkgs; [
    zsh-syntax-highlighting
    zsh-completions
    pure-prompt
  ];
}
