# My Personal Neovim Configuration

## Intro

This is just the [kickstarter](https://github.com/nvim-lua/kickstart.nvim) project made modular. I kept a lot of the comments for pursuing viewers. I think I kept 99% of the plugins that are found in the [kickstarter](https://github.com/nvim-lua/kickstart.nvim) project, except [neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim).
I mean if you use that might as well use VSCode, right? This is just a record, nothing fancy. JK, use what makes you productive, that is the beauty of this project! 

If by some weird chance, you want to clone my config and just have it work:

### First Back up Your Current Configuration:

#### Windows
```powershell
if (Test-Path "$env:LOCALAPPDATA\nvim") { Copy-Item "$env:LOCALAPPDATA\nvim" "$env:LOCALAPPDATA\nvim.backup.$(Get-Date -Format yyyyMMddHHmmss)" -Recurse }
```
#### Mac or Linux
```bash
[ -d "$HOME/.config/nvim" ] && cp -R "$HOME/.config/nvim" "$HOME/.config/nvim.backup.$(date +%Y%m%d%H%M%S)"
```

### Second Clone the Repository
And if you are one of the cool kids and you are on a Unix or Unix like system:

#### Windows
```powershell
git clone https://github.com/underradicals/my-neovim-config.git "$env:LOCALAPPDATA\nvim"
```

#### Mac or Linux
```bash
git clone https://github.com/underradicals/my-neovim-config.git "$HOME/.config/nvim"
```
