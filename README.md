# Zed EBNF Extension

Zed extension that adds EBNF language support.

## Contents

- Tree-sitter grammar wiring for EBNF.
- Syntax highlighting and brackets rules.
- Sample EBNF files under `samples/`.

## Development

This repo is designed to live under a `zed-extensions/` parent folder.

- Make edits in this project.
- Reload the extension in Zed as needed.

## WSL Windows Sync Script

The script at `scripts/sync-to-windows.sh` is for WSL-to-Windows syncing.
It deletes the target project folder on the Windows side and then copies
this project over, so the Windows copy always matches the WSL copy.

Default target:
- `/mnt/c/Users/bvlou/projects/zed-extensions`

Usage:
```
./scripts/sync-to-windows.sh
```

Optional project name:
```
./scripts/sync-to-windows.sh zed-ebnf
```

### Tweaking the script

- Change `target_root` to point at a different Windows folder.
- If you want a different project name resolution, adjust `project_name`
  selection logic.
- The script removes the target folder before syncing. If you want a
  safer flow, add a prompt before `rm -rf`.

Warning: this script deletes the target project directory each run.
