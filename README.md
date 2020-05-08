# rubocop-g2

This repo contains custom rubocop rules for G2.

A good starting point for writing a custom parser is the `ruby-parse` command. This parses a snippet of ruby code with the same parser that rubocop ultimately uses to analyze code.

For example, `ruby-parse -e "class Foo < Draper; end"` returns
```
(class
  (const nil :Foo)
  (const nil :Draper) nil)
```
