Repetitive: Repetitive tasks eradicator module for Awesome WM
=============================================================

This module allow Awesome users to map F keys (F1-F12) to either select tags, clients or execute macros.

## Installation

In a terminal:

```sh
cd ~/.config/awesome
git clone https://github.com/Elv13/repetitive.git
```

In rc.lua (at line 1):
```lua
require("repetitive")
```

You are done!

## Usage

By default, nothing is done. If you use `mod4+F1`, it will set a keybindins 
on `F1` to focus the current client. If you use `alt+F1`, it will do the same
for the current tag. Pression `F1` will select the client/tag.