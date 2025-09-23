{ pkgs, lib, ... }: {
  home.username = "laraochan";
  home.homeDirectory = lib.mkForce "/Users/laraochan";

  home.packages = with pkgs; [
    claude-code
    gh
  ];

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "z" ];
    };
  };

  programs.git = {
    enable = true;
    userName = "laraochan";
    userEmail = "me@larao.dev";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code";
    };
  };

  home.stateVersion = "25.05";
}
