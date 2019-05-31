#!/bin/bash

for file in ~/.{bashrc,bash_prompt,aliases}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
