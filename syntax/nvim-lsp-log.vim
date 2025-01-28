hi def link LspDevLevelTrace DiagnosticInfo
hi def link LspDevLevelDebug DiagnosticInfo
hi def link LspDevLevelInfo DiagnosticInfo
hi def link LspDevLevelWarn DiagnosticWarn
hi def link LspDevLevelError DiagnosticError
hi def link LspDevLevelStart DiagnosticInfo
hi def link LspDevTimestamp @number
hi def link LspDevFilename @module
hi def link LspDevSeparator @comment
hi def link LspDevTableKey @field
hi def link LspDevTableString @string
hi def link LspDevTableNumber @number
hi def link LspDevTablePunctuation @punctuation.bracket
hi def link LspDevTable @text

syntax region LspDevTable start=/^{/ end=/^}/ contains=LspDevTableKey,LspDevTableString,LspDevTableNumber,LspDevTablePunctuation
syntax match LspDevLevelTrace /\[TRACE\]/
syntax match LspDevLevelDebug /\[DEBUG\]/
syntax match LspDevLevelInfo /\[INFO\]/
syntax match LspDevLevelWarn /\[WARN\]/
syntax match LspDevLevelError /\[ERROR\]/
syntax match LspDevLevelStart /\[START\]/
syntax match LspDevTimestamp /\[[0-9-]\{10} [0-9:]\{8}\]/
syntax match LspDevFilename /\v\.\.\..+:\d+/
syntax match LspDevSeparator /^-\{10,}/
syntax match LspDevTableKey /\v\w+\ze\s*\=/
syntax match LspDevTableString /"\v([^"]*)"/
syntax match LspDevTableNumber /\v\d+(\.\d+)?/
syntax match LspDevTablePunctuation /[{}=,]/
