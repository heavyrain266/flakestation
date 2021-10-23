set-option global lsp_diagnostic_line_error_sign '✕'
set-option global lsp_hover_anchor true

hook global WinSetOption filetype=(c|cpp|css|scss|go|html|javascript|lua|nix|python|ruby|rust) %{
    lsp-enable-window
}

define-command lsp-restart -docstring "restart lsp server" %{
    lsp-stop; lsp-start
}

define-command lsp-init -docstring "enable lsp and set up generic hooks" %{
    echo -debug "Enabling LSP for filetype %opt{filetype}"
    lsp-enable-window

    set-option window lsp_auto_highlight_references true

    # enable signature help in statuline
    lsp-auto-signature-help-enable

    # Semantic tokens
    hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
    hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
    hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens

    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window semantic-tokens
    }

    inlay-diagnostics-enable
}

hook global KakEnd .* lsp-exit

declare-option -hidden str modeline_progress ""

define-command -hidden -params 4 -override lsp-handle-progress %{
    set-option global modeline_progress %sh{
        echo $1${2:+": $2"}${3:+" $3%"}${4:+" ✓"}
    }
}
