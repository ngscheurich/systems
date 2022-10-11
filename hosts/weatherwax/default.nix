{ pkgs, ... }:

{
  imports = [
    ../../modules/darwin
    ../../modules/home
    ./configuration.nix
  ];

  home-manager = {
    users.nick = {
      imports = [
        ../../modules/home/cli
        ../../modules/home/code.nix
        ../../modules/home/crypt.nix
        ../../modules/home/devel.nix
        ../../modules/home/devops.nix
        ../../modules/home/git.nix
        ../../modules/home/prose.nix
        ../../modules/home/term.nix
        ../../modules/home/vim.nix
      ];
    };
  };
}
