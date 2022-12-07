{ pkgs ? import (
  builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/22.05.tar.gz";
    sha256 = "0d643wp3l77hv2pmg2fi7vyxn4rwy0iyr8djcw1h5x72315ck9ik";
  }
) {} }:

with pkgs;

let
  python3-with-my-packages = python3.withPackages (p: with p; [
    virtualenv
    requests
    boto3
  ]);
in {
  qpidEnv = stdenvNoCC.mkDerivation {
    name = "my_compiler_env";
    buildInputs = [
      gcc6
      cmake
      gdb
      gnumake
      ninja
      python3-with-my-packages
    ];
    
    shellHook = ''
      [ ! -d venv ] && python3 -m virtualenv venv
      source venv/bin/activate
      pip3 install conan==1.54.0
    '';
  };
}
