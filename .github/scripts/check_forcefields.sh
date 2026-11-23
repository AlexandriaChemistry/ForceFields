#!/usr/bin/env bash
# Validate each force field file given on the command line with
#   alexandria edit_ff -ff file.xml -validate
# which fails (exit status 1) when the stored checksum does not match the
# contents, or when parameters are outside their bounds, duplicated,
# negative where they may not be, or have a minimum above the maximum.
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
    out="$work/out.txt"
    (cd "$work" && alexandria edit_ff -ff "$abs" -validate -g edit_ff.log) > "$out" 2>&1
    status=$?
    # Versions of alexandria from before 1.95b-dev-20261123 neither check
    # the checksum with -validate nor give an exit status.
    if ! grep -q "^Checksum of " "$out"; then
        echo "::error::alexandria edit_ff -validate did not check the checksum of $ff; alexandria is too old or could not read the file"
        cat "$out"
        exit 1
    fi
    if [ "$status" -ne 0 ]; then
        echo "::error file=$ff::$ff did not pass alexandria edit_ff -validate"
        # The report of the validation, without the banner
        awk '/^Checksum of /{p=1} /^There are |^Converted old style|^Please check output/{p=0} p' "$out"
        nfail=$((nfail + 1))
        continue
    fi
    echo "OK  $ff"
done

if [ "$nfail" -gt 0 ]; then
    echo "$nfail force field file(s) failed the validation."
    exit 1
fi
