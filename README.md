Repetitive tasks eradicator for Awesome WM
==========================================

This module allow Awesome users to map keyboard shortcuts to actions. Supported
actions are:

 * Focus tag
 * Focus client and restore cursor position
 * Record/Play mouse+keyboards macros

There is 2 types of bindings:

 * **Semi static:** Use clients and tags properties to assign keybindings
 * **Dynamic:** Keyboard shortcus can be set and replaced at runtime

Dynamic shortcuts are assigned to F keys (F1-F12) to either select tags, clients
or execute macros. This is done by using alternate keys to set the shortcut mode.
The modes are:

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

| Mode       | Description                                       | Setter Mod   |
| ---------- | ------------------------------------------------- |:------------:|
| **none**   | Execute the F-key as a regular F-key (default)    | `none`       |
| **exec**   | Execute the command already set using modifiers   | `none`       |
| **client** | Assign a client to the F-key and save cursor      | `mod4`       |
| **tag**    | Assign a tag to be focussed when pressing the key | `mod1` (alt) |
| **macro**  | Record a macro until `Escape` is pressed          | `Control`    |

Semi static keyboard bindings are designed to be set by a third party rule
such as `Awful.rules` or [Tyrannical](https://github.com/Elv13/tyrannical). Once
the object is either activated (tag) or tagged (client), Repetitive will assign
the shortcuts based on the following criterias:

| Mode                   | Description                                      | Default  |
| ---------------------- | ------------------------------------------------ |:--------:|
| **shortcut**           | A shortcut, use the same syntax as rc.lua ones   | N/A      |
| **rotate_shortcut**    | Select the next instance                         | true     |
| **exclusive_shortcut** | Replace the previous shortcut used for this key★ | false    |
| **relative_shortcut**  | Use the tag index as `mod4+index` shortcut       | false    |
| **viewonly**           | Toggle a tag visibility instead of replacing it  | true     |

★ Can only replace shortcuts set by Repetitive, if one has been set using the
global or clients shortcut section of rc.lua, both will be executed.

Another way to assign a shortcut is when creating tags manually:

```lua
    local t = awful.tag.add("MyTag",{shortcut = { {"Mond4}, "e" }, --[[more options]] })
```

In a function:

```lua
    awful.tag.setproperty(t, "shortcut", { {"Mond4}, "e" })
```

Or for clients:

```lua
    awful.client.propoery.set(c,"shortcut", { {"Mond4}, "e" })
```
