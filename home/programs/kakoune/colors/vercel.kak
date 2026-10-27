# Vercel Dark theme for Kakoune
# Ported from the Helix "vercel" theme (home/programs/helix/themes/vercel.toml)
# so both editors look the same.

# For Code
face global value rgb:52a8ff
face global type rgb:c472fb
face global variable rgb:ededed
face global module rgb:c472fb
face global function rgb:c472fb
face global string rgb:62c073
face global keyword rgb:f75f8f
face global operator rgb:f75f8f
face global attribute rgb:c472fb
face global comment rgb:a1a1a1
face global documentation comment
face global meta rgb:52a8ff
face global builtin rgb:52a8ff+b

# For markup
face global title rgb:52a8ff
face global header rgb:52a8ff
face global mono rgb:62c073
face global block rgb:62c073
face global link rgb:52a8ff
face global bullet rgb:f75f8f
face global list rgb:f75f8f

# builtin UI faces
face global Default rgb:ededed,rgb:0a0a0a
face global PrimarySelection rgb:ededed,rgb:003870
face global SecondarySelection rgb:ededed,rgb:003870
face global PrimaryCursor rgb:0a0a0a,rgb:ededed
face global SecondaryCursor rgb:0a0a0a,rgb:ededed
face global PrimaryCursorEol rgb:0a0a0a,rgb:52a8ff
face global SecondaryCursorEol rgb:0a0a0a,rgb:52a8ff
face global LineNumbers rgb:878787,rgb:0a0a0a
face global LineNumberCursor rgb:ededed,rgb:0a0a0a+b
face global LineNumbersWrapped rgb:878787,rgb:0a0a0a
face global MenuForeground rgb:ededed,rgb:1a1a1a
face global MenuBackground rgb:ededed,rgb:1f1f1f
face global MenuInfo rgb:a1a1a1,rgb:000000
face global Information rgb:ededed,rgb:000000
face global Error rgb:ededed,rgb:f75f8f
face global DiagnosticError rgb:f75f8f+u
face global DiagnosticWarning rgb:ff9907+u
face global StatusLine rgb:ededed,rgb:000000
face global StatusLineMode rgb:0a0a0a,rgb:52a8ff
face global StatusLineInfo rgb:0a0a0a,rgb:62c073
face global StatusLineValue rgb:0a0a0a,rgb:c472fb
face global StatusCursor rgb:0a0a0a,rgb:52a8ff
face global Prompt rgb:ededed,rgb:0a0a0a
face global MatchingChar rgb:52a8ff+b
face global Whitespace rgb:2e2e2e,rgb:0a0a0a
face global BufferPadding rgb:2e2e2e,rgb:0a0a0a

# Not a builtin face: wired up manually below via
# `add-highlighter global/ line %{%val{cursor_line}} CursorLine`
# to mirror Helix's `editor.cursorline = true`.
face global CursorLine default,rgb:1a1a1a
