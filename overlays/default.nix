{
  # Overlay custom derivations into nixpkgs so you can use pkgs.<name>
  # These packages are automatically available in all modules and configurations
  customPackages = final: _prev:
    import ../pkgs {
      pkgs = final;
    };
}
