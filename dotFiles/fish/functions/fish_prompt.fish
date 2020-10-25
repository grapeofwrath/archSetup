function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color green
    printf '%s' $USER
    set_color normal
    printf ' in '

    set_color magenta
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    set_color magenta
    printf '↪ '
    set_color normal
end
