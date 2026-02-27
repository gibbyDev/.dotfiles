{ config, pkgs, lib, ... }:

let
  # Script to generate posting theme from pywal colors
  generate-posting-theme = pkgs.writeShellScriptBin "generate-posting-theme" ''
    #!/bin/bash
    
    # Get pywal colors
    WAL_COLORS="''${XDG_CACHE_HOME:-$HOME/.cache}/wal/colors"
    
    if [ ! -f "$WAL_COLORS" ]; then
      echo "Error: pywal colors file not found at $WAL_COLORS"
      exit 1
    fi
    
    # Read colors from wal
    mapfile -t COLORS < "$WAL_COLORS"
    
    # Extract colors (wal provides 16 colors)
    BG="''${COLORS[0]}"          # background
    FG_DARK="''${COLORS[8]}"     # dark foreground
    COLOR1="''${COLORS[1]}"      # red
    COLOR2="''${COLORS[2]}"      # green
    COLOR3="''${COLORS[3]}"      # yellow
    COLOR4="''${COLORS[4]}"      # blue
    COLOR5="''${COLORS[5]}"      # magenta
    COLOR6="''${COLORS[6]}"      # cyan
    COLOR7="''${COLORS[7]}"      # white
    
    POSTING_THEME_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/posting/themes"
    mkdir -p "$POSTING_THEME_DIR"
    
    # Generate theme from pywal colors with proper variable substitution
    cat > "$POSTING_THEME_DIR/pywal.yaml" <<THEMEOF
    # Posting theme generated from pywal colors
    name: pywal
    primary: '$COLOR4'       # Blue from wal
    secondary: '$COLOR3'     # Yellow from wal
    accent: '$COLOR6'        # Cyan from wal
    background: '$BG'        # Black background from wal
    surface: '$COLOR1'       # Dark red for panels
    panel: '$COLOR2'         # Green for panel backgrounds
    error: '$COLOR1'         # Red for errors
    success: '$COLOR2'       # Green for success
    warning: '$COLOR3'       # Yellow for warnings
    dark: true
    
    author: "pywal"
    description: "Posting theme synchronized with pywal colors"
    
    text_area:
      gutter: "bold $COLOR6"
      cursor: "reverse"
      cursor_line: "dim"
      selection: "reverse"
    
    url:
      base: "italic $COLOR6"
      protocol: "bold $COLOR4"
      separator: "dim"
    
    syntax:
      json_key: "italic $COLOR4"
      json_string: "$COLOR2"
      json_number: "$COLOR6"
      json_boolean: "$COLOR2"
      json_null: "underline $COLOR6"
    
    method:
      get: "$COLOR4"
      post: "$COLOR2"
      put: "$COLOR3"
      delete: "$COLOR1"
      patch: "$COLOR6"
      options: "$COLOR5"
      head: "$COLOR5"
    
    variable:
      resolved: "black on $COLOR2"
      unresolved: "black on $COLOR1"
    THEMEOF
    
    echo "Generated posting theme at $POSTING_THEME_DIR/pywal.yaml"
    echo "Restart posting to see the new colors"
  '';

in
{
  home.packages = with pkgs; [
    posting
    generate-posting-theme
  ];

  # Activation script to generate theme on profile activation
  home.activation.generatePostingTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${generate-posting-theme}/bin/generate-posting-theme || true
  '';

  # Main posting configuration
  xdg.configFile."posting/config.yaml" = {
    text = ''
      # Posting Configuration
      # Synchronized with pywal color scheme
      
      theme: pywal
      layout: vertical
      
      # UI Components
      heading:
        visible: true
        show_host: false
        show_version: false
      
      collection_browser:
        position: left
        show_on_startup: true
      
      url_bar:
        show_value_preview: true
        hide_secrets_in_value_preview: true
      
      response:
        prettify_json: true
        show_size_and_time: true
      
      text_input:
        blinking_cursor: true
      
      # Focus behavior
      focus:
        on_startup: url
      
      # Theme settings
      watch_themes: true
      load_user_themes: true
      load_builtin_themes: true
      
      # Environment
      use_host_environment: false
      watch_env_files: true
      watch_collection_files: true
      
      # External tools
      pager: less
      editor: nvim
    '';
  };
}
