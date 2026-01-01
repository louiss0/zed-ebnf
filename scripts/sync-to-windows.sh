#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(dirname "$script_dir")"
source_root="$(dirname "$project_root")"
source_root_name="$(basename "$source_root")"
if [[ "$source_root_name" != "zed-extensions" ]]; then
	echo "Error: script must live under a zed-extensions parent." >&2
	exit 1
fi

target_root="/mnt/c/Users/bvlou/projects/zed-extensions"
if [[ $# -gt 1 ]]; then
	echo "Usage: $(basename "$0") [project-name]" >&2
	exit 2
fi

project_name="${1:-}"
if [[ -z "$project_name" ]]; then
	current_dir="$(pwd -P)"
	if [[ "$current_dir" == "$project_root"* ]]; then
		project_name="$(basename "$project_root")"
	elif [[ "$current_dir" == "$source_root/scripts" ]]; then
		mapfile -t projects < <(find "$source_root" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort | rg -v '^\.')
		projects=("${projects[@]/scripts}")
		if [[ "${#projects[@]}" -eq 1 ]]; then
			project_name="${projects[0]}"
		else
			echo "Available projects:"
			printf '  %s\n' "${projects[@]}"
			read -r -p "Project name: " project_name
		fi
	elif [[ "$current_dir" != "$source_root"* ]]; then
		echo "Error: run from within $source_root or pass a project name." >&2
		exit 1
	else
		relative_path="${current_dir#"$source_root/"}"
		project_name="${relative_path%%/*}"
	fi

	if [[ -z "$project_name" || "$project_name" == "scripts" ]]; then
		echo "Error: run from a project folder or pass a project name." >&2
		exit 1
	fi
fi
source_path="$source_root/$project_name"
target_path="$target_root/$project_name"

if [[ ! -d "$source_path" ]]; then
	echo "Error: $source_path does not exist." >&2
	exit 1
fi

if [[ -e "$target_path" ]]; then
	rm -rf "$target_path"
fi
mkdir -p "$target_path"

rsync -a "$source_path/" "$target_path/"

echo "Synced $source_path -> $target_path"
