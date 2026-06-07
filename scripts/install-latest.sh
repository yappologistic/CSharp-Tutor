#!/usr/bin/env bash
set -euo pipefail

repository="yappologistic/CSharp-Tutor"
branch="master"
ref=""
destination_root="${HOME:-}/.codex/skills"
dry_run=0
no_backup=0
no_validate=0
list_installed=0
uninstall=0
keep_download=0

usage() {
  cat <<'EOF'
Downloads and installs the latest C# Tutor skills on Linux or macOS.

Usage:
  curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash

Options:
  --ref <ref>                Branch, tag, or commit to install.
  --branch <branch>          Backward-compatible branch option. Defaults to master.
  --repository <owner/repo>  GitHub repository. Defaults to yappologistic/CSharp-Tutor.
  --destination-root <path>  Codex skills directory. Defaults to ~/.codex/skills.
  --dry-run                  Show install/update/remove actions without changing files.
  --no-backup                Skip backups of existing csharp-* skill folders.
  --no-validate              Skip skill validation even if quick_validate.py is available.
  --list-installed           List installed csharp-* skill folders and exit.
  --uninstall                Remove installed csharp-* skill folders.
  --keep-download            Keep the downloaded archive for troubleshooting.
  -h, --help                 Show this help.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ref)
      ref="${2:-}"
      shift 2
      ;;
    --branch)
      branch="${2:-}"
      shift 2
      ;;
    --repository)
      repository="${2:-}"
      shift 2
      ;;
    --destination-root)
      destination_root="${2:-}"
      shift 2
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    --no-backup)
      no_backup=1
      shift
      ;;
    --no-validate)
      no_validate=1
      shift
      ;;
    --list-installed)
      list_installed=1
      shift
      ;;
    --uninstall)
      uninstall=1
      shift
      ;;
    --keep-download)
      keep_download=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ -z "$ref" ]]; then
  ref="$branch"
fi

if [[ -z "$destination_root" ]]; then
  echo "HOME is not set. Pass --destination-root explicitly." >&2
  exit 1
fi

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Required command not found: $1" >&2
    exit 1
  fi
}

find_validator() {
  local candidate
  candidate="$destination_root/.system/skill-creator/scripts/quick_validate.py"
  if [[ -f "$candidate" ]]; then
    printf '%s\n' "$candidate"
    return 0
  fi

  if [[ -n "${HOME:-}" ]]; then
    candidate="$HOME/.codex/skills/.system/skill-creator/scripts/quick_validate.py"
    if [[ -f "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  fi

  return 1
}

list_installed_skills() {
  echo "Destination root: $destination_root"
  if [[ ! -d "$destination_root" ]]; then
    echo "No installed csharp-* skill folders found."
    return 0
  fi

  shopt -s nullglob
  local installed=("$destination_root"/csharp-*)
  shopt -u nullglob
  if [[ ${#installed[@]} -eq 0 ]]; then
    echo "No installed csharp-* skill folders found."
    return 0
  fi

  local skill
  for skill in "${installed[@]}"; do
    [[ -d "$skill" ]] && echo "$(basename "$skill") $skill"
  done
  echo "Installed C# Tutor skill folders: ${#installed[@]}"
}

backup_skill() {
  local skill="$1"
  local backup_root="$2"
  local target="$backup_root/$(basename "$skill")"
  if [[ "$dry_run" -eq 1 ]]; then
    echo "Would back up existing $skill to $target"
    return
  fi

  mkdir -p "$backup_root"
  cp -R "$skill" "$target"
}

install_from_source() {
  local source_root="$1"
  local source_ref="$2"
  local version="unknown"
  if [[ -f "$source_root/VERSION" ]]; then
    version="$(tr -d '\r\n' < "$source_root/VERSION")"
  fi

  shopt -s nullglob
  local skills=("$source_root"/csharp-*)
  shopt -u nullglob
  if [[ ${#skills[@]} -eq 0 ]]; then
    echo "No csharp-* skill folders found under $source_root" >&2
    exit 1
  fi

  echo "Source root: $source_root"
  echo "Source ref: $source_ref"
  echo "C# Tutor version: $version"
  echo "Destination root: $destination_root"
  echo "Skill folders: ${#skills[@]}"

  if [[ "$list_installed" -eq 1 ]]; then
    list_installed_skills
    return
  fi

  local backup_root="$destination_root/.backup/csharp-tutor-$(date +%Y%m%d-%H%M%S)"

  if [[ "$uninstall" -eq 1 ]]; then
    if [[ ! -d "$destination_root" ]]; then
      echo "No installed csharp-* skill folders found."
      return
    fi

    shopt -s nullglob
    local installed=("$destination_root"/csharp-*)
    shopt -u nullglob
    if [[ ${#installed[@]} -eq 0 ]]; then
      echo "No installed csharp-* skill folders found."
      return
    fi

    local installed_skill
    for installed_skill in "${installed[@]}"; do
      [[ -d "$installed_skill" ]] || continue
      if [[ "$no_backup" -eq 0 ]]; then
        backup_skill "$installed_skill" "$backup_root"
      fi
      if [[ "$dry_run" -eq 1 ]]; then
        echo "Would remove $installed_skill"
      else
        rm -rf "$installed_skill"
      fi
    done
    echo "Uninstalled C# Tutor skill folders: ${#installed[@]}"
    [[ "$no_backup" -eq 0 ]] && echo "Backup location: $backup_root"
    return
  fi

  if [[ "$no_validate" -eq 0 ]]; then
    local validator=""
    if validator="$(find_validator)"; then
      local skill
      for skill in "${skills[@]}"; do
        echo "Validating $(basename "$skill")"
        python3 "$validator" "$skill"
      done
    else
      echo "Warning: quick_validate.py was not found. Skipping validation." >&2
    fi
  fi

  if [[ "$dry_run" -eq 1 ]]; then
    echo "Dry run only. No files will be copied."
    local skill target
    for skill in "${skills[@]}"; do
      [[ -d "$skill" ]] || continue
      target="$destination_root/$(basename "$skill")"
      if [[ -d "$target" ]]; then
        [[ "$no_backup" -eq 0 ]] && echo "Would back up existing $target"
        echo "Would update $target from $skill"
      else
        echo "Would install $target from $skill"
      fi
    done
    return
  fi

  mkdir -p "$destination_root"
  local skill target
  for skill in "${skills[@]}"; do
    [[ -d "$skill" ]] || continue
    target="$destination_root/$(basename "$skill")"
    if [[ "$no_backup" -eq 0 && -d "$target" ]]; then
      backup_skill "$target" "$backup_root"
    fi
    rm -rf "$target"
    cp -R "$skill" "$target"
  done

  echo "Installed or updated ${#skills[@]} C# Tutor skill folders."
  echo "C# Tutor version: $version"
  [[ "$no_backup" -eq 0 ]] && echo "Backup location: $backup_root"
  echo "Restart Codex or open a new thread if the skill picker does not refresh immediately."
}

require_command curl
require_command unzip

temp_root="$(mktemp -d "${TMPDIR:-/tmp}/csharp-tutor-install.XXXXXX")"
archive="$temp_root/source.zip"
extract_root="$temp_root/source"

cleanup() {
  if [[ "$keep_download" -eq 1 ]]; then
    echo "Kept downloaded files at $temp_root"
  else
    rm -rf "$temp_root"
  fi
}
trap cleanup EXIT

archive_url="https://github.com/$repository/archive/$ref.zip"
echo "Downloading C# Tutor skills from $archive_url"
curl -fsSL "$archive_url" -o "$archive"

echo "Extracting package"
mkdir -p "$extract_root"
unzip -q "$archive" -d "$extract_root"

repo_root="$(find "$extract_root" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "$repo_root" ]]; then
  echo "Downloaded archive did not contain a repository folder." >&2
  exit 1
fi

install_from_source "$repo_root" "$repository@$ref"
