# Global options

# Default indention size
set-option global indentwidth 4
set-option global tabstop 4

# Never show changelog on startup
set-option global startup_info_version 99991231

# Cat => Clippy + disable window title
set-option global ui_options terminal_assistant=cat terminal_set_title=false

# Show relative line number-lines
add-highlighter global/ number-lines -relative -hlcursor -separator "  " -min-digits 4

# Show matching
add-highlighter global/ show-matching

# Highlight TODO, FIXME, XXX and NOTE
add-highlighter global/ regex \b(TODO|FIXME|XXX|NOTE)\b 0:default+rb

