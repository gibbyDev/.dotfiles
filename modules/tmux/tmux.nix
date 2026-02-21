{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";  # Ensures proper color support
    shell = "${pkgs.zsh}/bin/zsh"; # Forces tmux to use Zsh by default

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      rose-pine  # Rose Pine theme plugin for tmux
      resurrect
      continuum
    ];
extraConfig = ''
  # Only clone TPM if it doesn't exist
  if-shell "test ! -d ~/.tmux/plugins/tpm" \
    "run-shell 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'"

  # Run TPM (handles plugin installation)
  run-shell '~/.tmux/plugins/tpm/tpm'

  # Basic terminal setup
  set -g default-terminal "screen-256color"
  set-option -ga terminal-overrides ",xterm-256color:Tc"
  set-option -g default-command "zsh -l"
  setw -g mode-keys vi
  set -g base-index 1
  set -g status-position top
  set -g status-style "bg=default"

  # Pane navigation
  bind-key h select-pane -L
  bind-key j select-pane -D
  bind-key k select-pane -U
  bind-key l select-pane -R
  bind-key % split-window -h -c "#{pane_current_path}"
  bind-key '"' split-window -v -c "#{pane_current_path}"

  # Prefix key
  set -g prefix C-s  # C-s is awkward; C-a is standard and works better
  bind C-s send-prefix

  # Rose Pine Theme
  set -g @rose_pine_variant 'main'
  set -g @rose_pine_host 'on'
  set -g @rose_pine_user 'on'
  set -g @rose_pine_directory 'on'
  set -g @rose_pine_date_time '%a %b %d %H:%M:%S %Y'
  set -g @rose_pine_left_separator ' > '
  set -g @rose_pine_right_separator ' < '
  set -g @rose_pine_field_separator ' | '
  set -g @rose_pine_window_separator ' - '
  set -g @rose_pine_window_status_separator "  "
  set -g @rose_pine_hostname_icon '󰒋'
  set -g @rose_pine_date_time_icon '󰃰'

  # Pywal support
  if-shell "test -f ~/.cache/wal/colors-tmux.sh" \
    "source-file ~/.cache/wal/colors-tmux.sh"
  # Watch for updates
  run-shell "while inotifywait -e close_write ~/.cache/wal/colors-tmux.sh; do tmux source-file ~/.cache/wal/colors-tmux.sh; done &"

  # Enable mouse and scrollback
  set -g mouse on
  setw -g history-limit 10000

  # Automatic system clipboard copy for selections
  bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy"
  bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel "wl-copy"

  # TPM plugins
  set -g @plugin 'tmux-plugins/tpm'
  set -g @plugin 'tmux-plugins/vim-tmux-navigator'
  set -g @plugin 'rose-pine/tmux'

  # Automatically install missing plugins on start
  run-shell '~/.tmux/plugins/tpm/bin/install_plugins'
'';
  #   extraConfig = ''
  #
  #       # Install TPM manually
  # if-shell "test ! -d ~/.tmux/plugins/tpm" "run-shell 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'"
  # run-shell '~/.tmux/plugins/tpm/tpm'
  #
  #
  #     # Use 256 colors
  #     set -g default-terminal "screen-256color"
  #     set-option -ga terminal-overrides ",xterm-256color:Tc"
  #
  #     # Load Powerlevel10k and Zsh configs
  #     set-option -g default-command "zsh -l"
  #
  #     # Source Pywal colors
  #     if-shell "test -f ~/.cache/wal/colors-tmux.sh" 'source-file ~/.cache/wal/colors-tmux.sh'
  #
  #     unbind r
  #     bind r source-file ~/.tmux.conf
  #
  #     set -g prefix C-s
  #     setw -g mode-keys vi
  #
  #     bind-key h select-pane -L
  #     bind-key j select-pane -D
  #     bind-key k select-pane -U
  #     bind-key l select-pane -R
  #
  #     # Rose Pine Theme Configuration
  #     set -g @rose_pine_variant 'main'
  #     set -g @rose_pine_host 'on'
  #     set -g @rose_pine_date_time '%a %b %d %H: %M: %S %Y'
  #     set -g @rose_pine_user 'on'
  #     set -g @rose_pine_directory 'on'
  #     set -g @rose_pine_left_separator ' > '
  #     set -g @rose_pine_right_separator ' < '
  #     set -g @rose_pine_field_separator ' | '
  #     set -g @rose_pine_window_separator ' - '
  #     set -g @rose_pine_hostname_icon '󰒋'
  #     set -g @rose_pine_date_time_icon '󰃰'
  #     set -g @rose_pine_window_status_separator "  "
  #
  #     # Override colors with pywal dynamically
  #     set -g status-style "bg=default"
  #
  #     bind-key % split-window -h -c "#{pane_current_path}"
  #     bind-key '"' split-window -v -c "#{pane_current_path}"
  #
  #     set -g status-position top
  #     set -g base-index 1
  #
  #      # Automatically reload pywal colors when they update
  #      run-shell "while inotifywait -e close_write ~/.cache/wal/colors-tmux.sh; do tmux source-file ~/.cache/wal/colors-tmux.sh; done &"
  #   '';
  };
}

