#!/usr/bin/env bash

export LC_ALL='C';

REQUIRED_APPS=( convert );
FONT_SIZE="16";
IMAGE_SIZE="24x24";
BASE_DIR="$(dirname $(readlink -f $0))";

declare -A FONTS_MAP=(
    ['BOLD']="$BASE_DIR/fonts/UbuntuMono-B.ttf"
    ['REGULAR']="$BASE_DIR/fonts/UbuntuMono-R.ttf"
);

LAYOUTS=(
    "us" "af" "al" "am" "at" "az" "by" "be" "bd" "in" "ba" "br" "bg" "ma" "cm"
    "mm" "ca" "cd" "cn" "hr" "cz" "dk" "nl" "bt" "ee" "ir" "iq" "fo" "fi" "fr"
    "gh" "gn" "ge" "de" "gr" "hu" "is" "il" "it" "jp" "kg" "kh" "kz" "la" "lt"
    "lv" "me" "mk" "mt" "mn" "no" "pl" "pt" "ro" "ru" "rs" "si" "sk" "es" "se"
    "ch" "sy" "tj" "lk" "th" "tr" "tw" "ua" "gb" "uz" "vn" "kr" "ie" "pk" "mv"
    "za" "np" "ng" "et" "sn" "tm" "ml" "tz" "ke" "bw" "ph" "md" "zz"
);

function usage () {
    printf "%s\n\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
        "Usage: $(basename $0) [OPTIONS]" \
        "--fc         - font color" \
        "--bc         - background color" \
        "--sc         - shadow color" \
        "--dir        - output directory" \
        "--bold       - use bold font" \
        "--format     - type of string formatting" \
        "               0 - us (Default), 1 - US, 2 - Us" \
        "-h | --help  - show this help"
}

function require () {
    local NF;
    while (($#)); do
        test -z $(which $1 2> /dev/null) && NF+=("$1");
        shift;
    done

    # Return the elements of array what have been not found
    test ${#NF[@]} -ne 0 && {
        echo ${NF[@]} && return 1;
    }

    return 0;
}

function is_hex_color () {
    COLOR=$(echo "$1" | grep -P '(?i)#([a-z0-9]{3}|[a-z0-9]{6}|[a-z0-9]{8})$');
    test -n "$COLOR" || return 1;
    return 0;
}

function lc () {
    TEXT="$1";
    echo ${TEXT,,}
}

function uc () {
    TEXT="$1";
    echo ${TEXT^^}
}

function fu () {
    TEXT=$(lc "$1");
    echo ${TEXT^}
}

NOT_FOUND=( $(require ${REQUIRED_APPS[@]}) ) || {
    echo "Error! Unresolved dependencies: $(printf '%s ' ${NOT_FOUND[@]})" 1>&2;
    exit 1;
}

OPTS=$(getopt -o h --long bold,fc:,bc:,sc:,dir:,format:,help -- "$@")
test $? != 0 && {
    usage;
    exit 3;
}
eval set -- "$OPTS";

BG="#373737";
FG="#FFFFFF";
SG="#000000";
TEXT_FORMAT=0; # 0 - us, 1 - US, 2 - Us
OUT_DIR="$BASE_DIR/images";

while true
do
    case "$1" in
        --fc) FG="$2"; shift 2 ;;
        --bc) BG="$2"; shift 2 ;;
        --sc) SG="$2"; shift 2 ;;
        --dir) OUT_DIR="$2"; shift 2 ;;
        --bold) BOLD=1; shift ;;
        --format) TEXT_FORMAT="$2"; shift 2 ;;
        -h | --help) usage; exit 1 ;;
        --) shift; break ;;
        *) usage; exit 1 ;;
    esac
done

test -n "$BOLD" && {
    FONT=${FONTS_MAP['BOLD']};
} || {
    FONT=${FONTS_MAP['REGULAR']};
}

test -r "$FONT" || {
    echo "Error! File '$FONT' isn't exist" 1>&2;
    exit 2;
}

mkdir -p "$OUT_DIR" 2> /dev/null;
touch "$OUT_DIR/is_writable" 2> /dev/null || {
    echo "Error! '$OUT_DIR' directory isn't writable" 1>&2;
    exit 3;
}
unlink "$OUT_DIR/is_writable";

expr match "$TEXT_FORMAT" '^[0-2]$' &>/dev/null || {
    echo "Error! Invalid type of string formatting" 1>&2;
    usage;
    exit 4;
}

is_hex_color "$FG" || {
    echo "Error! Invalid font color" 1>&2;
    exit 5;
}

is_hex_color "$BG" || {
    echo "Error! Invalid background color" 1>&2;
    exit 6;
}

is_hex_color "$SG" || {
    echo "Error! Invalid shadow color" 1>&2;
    exit 7;
}

for i in ${LAYOUTS[@]}
do
    test $i = "zz" && TEXT="?" || TEXT="$i";
    case $TEXT_FORMAT in
        0) TEXT=$(lc $TEXT) ;;
        1) TEXT=$(uc $TEXT) ;;
        2) TEXT=$(fu $TEXT) ;;
        *) echo "Error! Unknown text format: $TEXT_FORMAT" 1>&2; exit 8 ;;
    esac
    convert -size "$IMAGE_SIZE" xc:"$BG" \
        -font "$FONT" -antialias \
        -pointsize "$FONT_SIZE" -gravity center \
        -fill "$SG" -draw "text 2,1 ${TEXT}" \
        -fill "$FG" -draw "text 1,0 ${TEXT}" \
        "$OUT_DIR/$i.png";
    echo "* Generating '$OUT_DIR/$i.png'";
done

exit 0;
