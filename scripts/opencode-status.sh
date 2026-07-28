#!/bin/sh
# tmux status bar: report opencode sessions that are waiting for input.
#
# When opencode is actively processing, the footer shows "esc interrupt" (the
# user can press escape to interrupt). When it is idle and ready for the next
# message — or waiting on a permission prompt / question dialog — that text is
# absent. We treat an opencode pane with no "esc interrupt" as "waiting".
#
# Only the last 5 lines of the pane are checked. Those are the input-box area
# below the border that separates it from the conversation transcript, so tool
# output rendered above the border can't trigger a false positive.
#
# Output is empty when no session is waiting; otherwise a styled indicator
# listing the waiting window indices, e.g.  OC waiting:1,4
# Style codes (#[...]) are interpreted by tmux in the status bar.

tmux list-panes -a -F '#{pane_id}	#{window_index}	#{pane_current_command}' 2>/dev/null |
while IFS='	' read -r pane_id win_idx cmd; do
    [ "$cmd" = "opencode" ] || continue
    tmux capture-pane -t "$pane_id" -p 2>/dev/null | tr -d '\r' | tail -5 |
    grep -q 'esc interrupt' ||
    printf '%s\n' "$win_idx"
done |
sort -un | paste -sd, - |
{ read -r wins; [ -n "$wins" ] && printf '#[fg=black,bg=colour226,bold] OC waiting:%s #[default]' "$wins"; }
