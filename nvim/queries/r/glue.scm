((string) @string
  (#match? @string "\\{[^}]+\\}")
  (injection content: (raw_text) language: "r"))
