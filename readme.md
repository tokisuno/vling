# vimling.nvim
This is simply a lua rewrite of Luke Smith's vimling plugin, with some added characters.

Here's the [original plugin!](https://github.com/LukeSmithxyz/vimling) I used it for quite a few assignments for undergraduate linguistics courses. The only reason I decided to rewrite it in lua was in hopes that it's faster(?), but I can't even tell if that's true so you can be the judge of that LOL. Either way, I became more familiar with how to make things talk to one another in nvim so that's a plus :)

# installation
## lazy.nvim
```lua
return {
    {
        "tokisuno/vling",
        dependencies = "tjdevries/stackmap.nvim"
    }
}
```

# usage
```lua
-- example mapping
local deadkeys = require('vling').deadkeys.toggle()
vim.keymap.set("n", "<leader>td", deadkeys )
```
