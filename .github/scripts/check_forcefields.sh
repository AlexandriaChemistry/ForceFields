#!/usr/bin/env bash
# Verify that each force field file given on the command line can be read
# by ACT and that its stored checksum matches its content.
# Usage: check_forcefields.sh file.xml [file.xml ...]
# Needs the program alexandria in PATH.
set -u

nfail=0
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

for ff in "$@"; do
    if [ ! -f "$ff" ]; then
        continue
    fi
    abs=$(cd "$(dirname "$ff")" && pwd)/$(basename "$ff")
    log="$work/edit_ff.log"
    rm -f "$log"
    if ! grep -q '<version[^>]*checksum="[0-9a-f]\{32\}"' "$ff"; then
        echo "::error file=$ff::no checksum in the version element of $ff"
        nfail=$((nfail + 1))
        continue
    fi
    if ! (cd "$work" && alexandria edit_ff -ff "$abs" -g "$log") > "$work/out.txt" 2>&1; then
        echo "::error file=$ff::alexandria could not read $ff"
        cat "$work/out.txt" "$log" 2>/dev/null
        nfail=$((nfail + 1))
        continue
    fi
    if grep -q "Checksum mismatch" "$log"; then
        echo "::error file=$ff::$(grep 'Checksum mismatch' "$log")"
        nfail=$((nfail + 1))
        continue
    fi
    echo "OK  $ff"
done

if [ "$nfail" -gt 0 ]; then
    echo "$nfail force field file(s) failed the check."
    exit 1
fi
