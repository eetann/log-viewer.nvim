hi def link LogViewerLevelTrace DiagnosticInfo
hi def link LogViewerLevelDebug DiagnosticInfo
hi def link LogViewerLevelInfo DiagnosticInfo
hi def link LogViewerLevelWarn DiagnosticWarn
hi def link LogViewerLevelError DiagnosticError
hi def link LogViewerLevelStart DiagnosticInfo
hi def link LogViewerTimestamp @number
hi def link LogViewerFilename @module
hi def link LogViewerSeparator @comment
hi def link LogViewerTableKey @field
hi def link LogViewerTableString @string
hi def link LogViewerTableNumber @number
hi def link LogViewerTablePunctuation @punctuation.bracket
hi def link LogViewerTable @text

syntax region LogViewerTable start=/^{/ end=/^}/ contains=LogViewerTableKey,LogViewerTableString,LogViewerTableNumber,LogViewerTablePunctuation
syntax match LogViewerLevelTrace /\[TRACE\]/
syntax match LogViewerLevelDebug /\[DEBUG\]/
syntax match LogViewerLevelInfo /\[INFO\]/
syntax match LogViewerLevelWarn /\[WARN\]/
syntax match LogViewerLevelError /\[ERROR\]/
syntax match LogViewerLevelStart /\[START\]/
syntax match LogViewerTimestamp /\[[0-9-]\{10} [0-9:]\{8}\]/
syntax match LogViewerFilename /\v\.\.\..+:\d+/
syntax match LogViewerSeparator /^-\{10,}/
syntax match LogViewerTableKey /\v\w+\ze\s*\=/
syntax match LogViewerTableString /"\v([^"]*)"/
syntax match LogViewerTableNumber /\v\d+(\.\d+)?/
syntax match LogViewerTablePunctuation /[{}=,]/
