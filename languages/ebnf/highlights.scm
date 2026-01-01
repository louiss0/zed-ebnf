(comment) @comment
(meta_identifier) @constant
(terminal_string) @string
(integer) @number
(special_sequence) @string.special
[
  "["
  "]"
] @punctuation.bracket
[
  "{"
  "}"
  "("
  ")"
] @punctuation.delimiter
[
  (defining_symbol)
  (definition_separator)
  (repetition_symbol)
  (except_symbol)
  (concatenate_symbol)
  (range_operator)
  (terminator_symbol)
] @operator
(markdown_heading1) @title
(markdown_heading) @title
