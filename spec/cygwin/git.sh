#!/usr/bin/env bash

# It is TOO SLOW

resolve_git_path() {
    #escape (SPACE) in $PATH
    EPATH=$(printf "%q" "$PATH")

    #split path by colon
    OLD_IFS="$IFS"
    IFS=":"
    path_list=($EPATH)
    IFS="$OLD_IFS"

    self_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

    for ((i = 0; i < ${#path_list[@]}; i++))
    do
        bin_dir="${path_list[$i]}"
        if [[ $self_dir != $bin_dir ]] && [[ -x $bin_dir/git ]];then
            echo $bin_dir"/git"
            exit 0
        fi
    done

    unset EPATH OLD_IFS self_dir bin_dir
}

main() {
    git=$(resolve_git_path)
    if [[ -z $git ]];then
        echo "command not found: git"
        exit 127
    fi

    argv=()
    for a in "$@"
    do
        # test ./git.sh https://github.com/json-iterator/go D:\cygwin64\home\user\GoWorkSpace\src\github.com\json-iterator\go
        # failed to get slash from params
        if [[ "$a" =~ ^[D|d]: ]];then
            fa=$(echo $a | sed 's/^[D|d]:/\/cygdrive\/d/g')
            fa=$(echo $fa | sed 's/\\/\//g')
            argv+=" $fa"
        else
            argv+=" $a"
        fi
    done

    echo $git $argv
    #$git $argv
    return "$?"

    unset git argv
}

# https://stackoverflow.com/a/11825060/4854570
# these is not work, I'm tired
argv=$(history | tail -1)
echo "argv: "$argv
exit 0
main "$@"

#vim: ft=bash et st=4 sw=4
