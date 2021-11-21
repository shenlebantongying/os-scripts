# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](rkt|rktd|rktl|rkts) %{
  set-option buffer filetype racket
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=racket %{
  require-module racket
  set-option buffer extra_word_chars '-' '>' '!' '$' '%' '&' '*' '+' '-' '.' '/' ':' '<' '=' '>' '?' '@' '^' '_' '~'
  set-option buffer comment_line ';'
  set-option buffer comment_block_begin '#|'
  set-option buffer comment_block_end '|#'
}

hook -group racket-highlight global WinSetOption filetype=racket %{
  add-highlighter -override window/racket ref racket
}

# --------------------------------------------------------------------------------------------------- #
provide-module -override racket %§

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter -override shared/racket regions
add-highlighter -override shared/racket/code default-region group

add-highlighter -override shared/racket/comment       region ';' '$' fill comment
add-highlighter -override shared/racket/comment-form  region -recurse "\(" "#;\(" "\)" fill comment
add-highlighter -override shared/racket/comment-block region "#\|" "\|#" fill comment

§

