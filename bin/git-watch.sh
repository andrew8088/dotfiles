#!/bin/bash
#
# Example output:
#
#   feature/add-auth (14:32:07)
#
#   Staged:
#     A  src/auth.ts (staged)
#
#   Unstaged:
#     M  src/index.ts
#
#   Untracked:
#     ?? notes.txt
#
#
#   Recent commits:
#     a1b2c3d Add login endpoint (2 hours ago)
#     e4f5g6h Fix typo in README (3 hours ago)
#     i7j8k9l Initial commit (2 days ago)
#
#   Branch changes vs origin/main (3 files):
#     A  src/auth.ts
#     M  src/index.ts
#     M  package.json
#
#   Stashes (2):
#     stash@{0}: WIP on feature/add-auth: a1b2c3d Add login endpoint
#     stash@{1}: On main: experimental changes
#
#   Ctrl+C to stop | Refresh: 1s
#

REPO_DIR="${1:-.}"
INTERVAL="${2:-1}"

cd "$REPO_DIR" || { echo "Error: Cannot cd to $REPO_DIR"; exit 1; }

if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: Not a git repository"
    exit 1
fi

cleanup() {
    printf "\033[?25h"
    echo -e "\nStopped."
    exit 0
}

trap cleanup INT TERM EXIT

printf "\033[?25l"
clear

render() {
    local buf=""
    local line
    while IFS= read -r line || [[ -n "$line" ]]; do
        buf+="${line}\033[K\n"
    done
    printf "\033[H"
    printf "%b" "$buf"
    printf "\033[J"
}

while true; do
    {
        branch=$(git branch --show-current 2>/dev/null || echo "detached")
        echo -e "\033[1m$branch ($(date '+%H:%M:%S'))\033[0m"
        echo ""

        status=$(git status --porcelain 2>/dev/null || true)

        if [[ -z "$status" ]]; then
            echo "Clean working tree"
        else
            staged=""
            unstaged=""
            untracked=""

            while IFS= read -r line; do
                [[ -z "$line" ]] && continue
                index="${line:0:1}"
                worktree="${line:1:1}"
                file="${line:3}"

                case "$index" in
                    M) staged+="  \033[32mM\033[0m  $file (staged)\n" ;;
                    A) staged+="  \033[32mA\033[0m  $file (staged)\n" ;;
                    D) staged+="  \033[32mD\033[0m  $file (staged)\n" ;;
                    R) staged+="  \033[32mR\033[0m  $file (staged)\n" ;;
                esac

                case "$worktree" in
                    M) unstaged+="  \033[31mM\033[0m  $file\n" ;;
                    D) unstaged+="  \033[31mD\033[0m  $file\n" ;;
                esac

                if [[ "$index" == "?" ]]; then
                    untracked+="  \033[33m??\033[0m $file\n"
                fi
            done <<< "$status"

            [[ -n "$staged" ]] && echo -e "\033[1mStaged:\033[0m\n$staged"
            [[ -n "$unstaged" ]] && echo -e "\033[1mUnstaged:\033[0m\n$unstaged"
            [[ -n "$untracked" ]] && echo -e "\033[1mUntracked:\033[0m\n$untracked"
        fi

        echo ""
        echo ""
        echo -e "\033[1mRecent commits:\033[0m"
        git log --format="%h|%ar|%s" -5 2>/dev/null | while IFS='|' read -r hash ago msg; do
            echo -e "  \033[33m$hash\033[0m $msg \033[2m($ago)\033[0m"
        done

        if [[ "$branch" != "main" && "$branch" != "master" && "$branch" != "detached" ]]; then
            base=""
            if git rev-parse --verify origin/main >/dev/null 2>&1; then
                base="origin/main"
            elif git rev-parse --verify origin/master >/dev/null 2>&1; then
                base="origin/master"
            fi

            if [[ -n "$base" ]]; then
                merge_base=$(git merge-base "$base" HEAD 2>/dev/null)
                if [[ -n "$merge_base" ]]; then
                    changed_files=$(git diff --name-status "$merge_base" HEAD 2>/dev/null)
                    if [[ -n "$changed_files" ]]; then
                        file_count=$(echo "$changed_files" | wc -l | tr -d ' ')
                        echo ""
                        echo -e "\033[1mBranch changes vs $base ($file_count files):\033[0m"
                        echo "$changed_files" | while IFS=$'\t' read -r fstatus file; do
                            case "$fstatus" in
                                A) echo -e "  \033[32mA\033[0m  $file" ;;
                                M) echo -e "  \033[34mM\033[0m  $file" ;;
                                D) echo -e "  \033[31mD\033[0m  $file" ;;
                                R*) echo -e "  \033[35mR\033[0m  $file" ;;
                                *) echo -e "  \033[33m$fstatus\033[0m  $file" ;;
                            esac
                        done
                    fi
                fi
            fi
        fi

        stash_list=$(git stash list 2>/dev/null | head -5 || true)
        if [[ -n "$stash_list" ]]; then
            total_stashes=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
            echo ""
            echo -e "\033[1mStashes ($total_stashes):\033[0m"
            while IFS= read -r line; do
                echo "  $line"
            done <<< "$stash_list"
        fi

        echo ""
        echo -e "\033[2mCtrl+C to stop | Refresh: ${INTERVAL}s\033[0m"
    } | render

    sleep "$INTERVAL"
done
