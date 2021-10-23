define-command -hidden html-auto-close-tag %{
    evaluate-commands -draft -intersel -save-regs '"^' %{
        try %{
            execute-keys -draft hH<a-k><lt><ret>
            execute-keys -save-regs '' Z[
            execute-keys -with-maps t
            execute-keys -save-regs '' ey
            execute-keys -save-regs '' zh<a-p>
            execute-keys -with-hooks a<gt>
        }
    }
}

hook global WinSetOption filetype=(xml|html|svelte) %{
    map -docstring "xml tag object" global object t %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}
    hook window InsertChar '/' html-auto-close-tag
}
