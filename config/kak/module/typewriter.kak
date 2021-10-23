declare-option -hidden line-specs typewriter_offset
declare-option -hidden int typewriter_last_line

define-command -hidden typewriter-update %{
    evaluate-commands %sh{
        if [ "$kak_cursor_display_column" -lt $((kak_window_width / 2)) ]; then
        	printf 'set-option window typewriter_offset %d "%d|%*s"' \
                "$kak_timestamp" \
                $((kak_cursor_line + 1)) \
                $((kak_window_width / 2 - kak_cursor_display_column))
        else
            echo unset-option window typewriter_offset
        fi
    }
}

define-command \
    -docstring "
    Enable typewriter mode, keeping the cursor horizontally centred
    " \
    typewriter-enable \
%{
    add-highlighter window/typewriter_indent flag-lines \
        default typewriter_offset

    execute-keys vm
    typewriter-update
    set-option window typewriter_last_line %val{cursor_line}

    hook -group typewriter-indent window NormalIdle .* %{
        eval %sh{
            if [ "$kak_opt_typewriter_last_line" -eq "$kak_cursor_line" ]; then
                echo execute-keys vm
                echo typewriter-update
            fi
        }
        set-option window typewriter_last_line %val{cursor_line}
    }
    hook -group typewriter-indent window InsertIdle .* %{
        execute-keys <a-semicolon>vm
        typewriter-update
        set-option window typewriter_last_line %val{cursor_line}
    }
}

define-command \
    -docstring "
    Disable typewriter mode
    " \
    typewriter-disable \
%{
    remove-hooks window typewriter-indent
    remove-highlighter window/typewriter_indent
    unset-option window typewriter_offset
    unset-option window typewriter_last_line
}
