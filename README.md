# lsp-dev.nvim
Help language server developers.

## ✨ Features
- 📜 LSP log viewer
- ⚡ Quickly switch log level

`:LspDev showLog`  
![showLog](https://github.com/user-attachments/assets/94424104-d10c-4733-9183-13423a963ba2)

`:LspDev changeLogLevel`  
![changeLogLevel](https://github.com/user-attachments/assets/fbb1a96b-0329-4666-9b02-d01073e177ae)


## 🔌 Requirements
- Neovim 0.10+
- [nui.nvim](https://github.com/MunifTanjim/nui.nvim)

## 📦 Installation


```lua
-- lazy.nvim
{
	dir = "eetann/lsp-dev.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {},
}
```

---

## TODO

- [x] パース(簡易的に)
- [x] 更新があれば表示
    - [x] raw
    - [x] パース
- [x] 境界の表示
- [x] ハイライト
- [x] レベルの切り替え
- [ ] ドキュメント書きましょうね
- [ ] 特定のプロパティを非表示
    - idやjsonrpcなど
- [ ] positionをプレビュー&ハイライトで表示
- [ ] 細かくパース
- [ ] viewerをbdeleteせずに他のバッファで上書きした場合、再度`:LspDev showLog`したらそのバッファを表示させる

- [ ] exit_handlerは非表示にする？
```
[INFO][2025-02-02 20:50:23] .../lua/vim/lsp.lua:799	"exit_handler"	{ {    _log_prefix = "LSP[tailwindcss]",    _on_attach_cbs = { <function 1> },    capabilities = <1>{      general = <2>{        positionEncodings = { "utf-16" }      }    },    commands = {},    <metatable> = <table 42>  } }
```
