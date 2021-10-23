# Global hooks

# Autowrap column (usually 80 characters)
hook global WinSetOption autowrap_column=.* %{
    add-highlighter -override window/wrap-column column %sh{
        echo $((kak_opt_autowrap_column + 1))
    } "default,%opt{column_color}"
    add-highlighter -override window/wrap-regex regex "^[^\n]{%opt{autowrap_column}}([^\n]*)$" "1:default,%opt{column_color}"
}

# Show hovered hex color on statuline
hook global WinSetOption filetype=.* %{ hook global NormalIdle .* %{
    evaluate-commands -save-regs 'a' %{ try %{
        execute-keys -draft <a-i>w"ay
        evaluate-commands %sh{ (
            color="${kak_reg_a}"
            inverted_color=$(echo "${color}" | perl -pe 'tr/0123456789abcdefABCDEF/fedcba9876543210543210/')
            printf "%s\n" "evaluate-commands -client $kak_client %{ try %{
                               echo -markup %{{rgb:${inverted_color},rgb:${color}+b}   #${color}   }
                           }}" | kak -p $kak_session
        ) >/dev/null 2>&1 </dev/null & }
    }}
}}
