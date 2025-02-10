# lsp-dev.nvim
Help language server developers.

## ✨ Features
- 📜 LSP log viewer
- 🗑️ Delete LSP log
- ⚡ Quickly switch log level
- 🔍 Show language server capabilities

`:LspDev showLog`  
![showLog](https://github.com/user-attachments/assets/94424104-d10c-4733-9183-13423a963ba2)

`:LspDev deleteLog`  
<img width="657" alt="deleteLog" src="https://github.com/user-attachments/assets/33169442-1d32-4e6e-a807-adcc4348e6e6" />

`:LspDev changeLogLevel`  
<img width="322" alt="changeLogLevel" src="https://github.com/user-attachments/assets/6c9d5dc7-94ed-488b-b141-bd3b91fba83b" />

`:LspDev showCapabilities`  
First, select from the list of currently active language servers.  
<img width="618" alt="choose language server" src="https://github.com/user-attachments/assets/0c7e7204-ed3a-4cb5-b809-dc978b563cf2" />  
Then the capabilities of that language server will be displayed.  
<img width="691" alt="capabilities" src="https://github.com/user-attachments/assets/3aeff988-fc65-46b7-af7d-8371a1dfecd0" />


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
	cmd = { "LspDev" },
	keys = {
		{ "<space>ls", ":LspDev showLog<CR>" },
		{ "<space>lc", ":LspDev changeLogLevel<CR>" },
	},
	opts = {},
}
```
