#!/bin/bash

target_window="$1"
if ! tmux list-panes -F "#{pane_current_command}" -t "$target_window" | grep -iqE "(n?vim)"; then
	    tmux set status on
    else
	        tmux set status off
fi
