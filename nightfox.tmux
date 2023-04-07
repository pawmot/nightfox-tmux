#!/usr/bin/env bash
PLUGIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
  get-tmux-option() {
    local option value default
    option="$1"
    default="$2"
    value="$(tmux show-option -gqv "$option")"

    if [ -n "$value" ]; then
      echo "$value"
    else
      echo "$default"
    fi
  }

  set() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
  }

  setw() {
    local option=$1
    local value=$2
    tmux set-window-option -gq "$option" "$value"
  }

  local theme
  theme="$(get-tmux-option "@carbonfox_style" "carbonfox")"

  # NOTE: Pulling in the selected theme by the theme that's being set as local
  # variables.
  sed -E 's/^(.+=)/local \1/' \
      > "${PLUGIN_DIR}/selected-theme.tmux" \
      < "${PLUGIN_DIR}/${theme}.tmuxtheme"

  source "${PLUGIN_DIR}/selected-theme.tmux"
  rm "${PLUGIN_DIR}/selected-theme.tmux"

  # status
  set status "on"
  set status-bg "${thm_bg}"
  set status-justify "left"
  set status-left-length "100"
  set status-right-length "100"

  # messages
  set message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
  set message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

  # panes
  set pane-border-style "fg=${thm_gray}"
  set pane-active-border-style "fg=${thm_blue}"

  # windows
  setw window-status-activity-style "bold"
  setw window-status-bell-style "bold"
  setw window-status-separator ""
  setw window-status-style "fg=${thm_fg},bg=${thm_bg},none"

  # clock
  set clock-mode-style 24

  set status-left "#{?client_prefix,#[bg=$thm_red],#[bg=$thm_green]}#[fg=$thm_bg,bold] #S #{?client_prefix,#[fg=$thm_red],#[fg=$thm_green]}#[bg=$thm_bg]"

  setw window-status-format "#[fg=$thm_blue,bg=$thm_bg]#[fg=$thm_bg,bg=$thm_blue] #I #[fg=$thm_blue,bg=$thm_gray] #W #[fg=$thm_gray,bg=$thm_bg]"

  setw window-status-current-format "#[fg=$thm_orange,bg=$thm_bg]#[fg=$thm_bg,bg=$thm_orange,bold] #I #[fg=$thm_orange,bg=$thm_gray] #W #[fg=$thm_gray,bg=$thm_bg]"

  set status-right "#[fg=$thm_gray,bg=$thm_bg]#[fg=$thm_blue,bg=$thm_gray]  %a %d/%m 󱑂 %R #(date +%Z) "

  # --------=== Modes

  setw clock-mode-colour "${thm_blue}"
  setw mode-style "fg=${thm_cyan} bg=${thm_gray} bold"
}

main "$@"
