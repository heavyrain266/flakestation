hook global WinSetOption filetype=lua %{
  set-option window tabstop 2
  set-option window softtabstop 2
  set-option window indentwidth 2

  hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
  hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
  hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
  hook -once -always window WinSetOption filetype=.* %{
      remove-hooks window semantic-tokens
  }
}
