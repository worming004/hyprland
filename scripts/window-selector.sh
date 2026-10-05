#!/usr/bin/env bash

set -euo pipefail

current_workspace="$(
  hyprctl activeworkspace -j |
    jq -r '.id'
)"

windows="$(
  hyprctl clients -j |
    jq -r '
            .[]
            | select(.class != "walker")
            | [
                .address,
                (.workspace.id | tostring),
                .class,
                .title
              ]
            | @tsv
        '
)"

[[ -z "$windows" ]] && exit 0

menu="$(
  while IFS=$'\t' read -r address workspace class title; do
    printf '%s\t[%s] %s — %s\n' \
      "$address" \
      "$workspace" \
      "$class" \
      "$title"
  done <<<"$windows"
)"

selected="$(
  printf '%s\n' "$menu" |
    walker --dmenu --placeholder "Select window"
)"

[[ -z "$selected" ]] && exit 0

address="${selected%%$'\t'*}"

selected_workspace="$(
  printf '%s\n' "$windows" |
    awk -F '\t' -v addr="$address" '
            $1 == addr {
                print $2
                exit
            }
        '
)"

focus_window() {
  hyprctl dispatch \
    "hl.dsp.focus({ window = 'address:$address' })"
}

move_window() {
  hyprctl dispatch \
    "hl.dsp.window.move({ workspace = '$current_workspace', window = 'address:$address' })"
}

float_window() {
  hyprctl dispatch \
    "hl.dsp.window.float({ window = 'address:$address', action = 'enable' })"
}

center_window() {
  hyprctl dispatch 'hl.dsp.window.center()'
}

# Already on the current workspace: just focus it.
if [[ "$selected_workspace" == "$current_workspace" ]]; then
  focus_window
  exit 0
fi

action="$(
  printf '%s\n' \
    "Focus" \
    "Move to current workspace" \
    "Move + float + center" |
    walker --dmenu --placeholder "Action"
)"

case "$action" in
"Focus")
  focus_window
  ;;

"Move to current workspace")
  move_window
  focus_window
  ;;

"Move + float + center")
  move_window
  float_window
  focus_window
  center_window
  ;;

*)
  exit 0
  ;;
esac
