# ✨ vling ✨ (vimling.nvim)
## Purpose
This is for other vim-using linguists who find it annoying to have to copy and paste IPA/accented characters. I have issues switching layouts in kitty + tmux so this helps me a lot :)

# Original vimscript plugin
*This is simply a lua rewrite of Luke Smith's vimling plugin, with some added characters.*

Here's the [original plugin!](https://github.com/LukeSmithxyz/vimling) I used it for quite a few assignments for undergraduate Linguistics courses.

# Demonstration
- TBA

# Installation
## lazy.nvim
```lua
--- source it however you like
{
    "tokisuno/vling"
}
```

## Example implementation
```lua
-- example mappings (the ones I use)
vim.keymap.set("n", "<leader>td", function () require('vling').deadkeys.toggle() end)
vim.keymap.set("n", "<leader>ti", function () require('vling').ipa.toggle() end)
```

# FAQ
## How do I know what each key-symbol does?
Unfortunately, there are two ways of going about this, you can either pull up the legend (TBA) for the respective mode, or you can view the source code to see if what you want is there. For some reason Whichkey doesn't pick up on these mappings for the time being :/

## Why I re-wrote this
The only reason I decided to rewrite it in lua was in hopes that it's faster(?), but I can't even tell if that's true so you can be the judge of that LOL. I was also reaching TJ teaching bashbunni about how to write a plugin, and the structure around stackmap seemed to spark something in me. In reality, this is just stackmap with already-made keymaps. The downsides to Luke Smith's plugin were that if you had keys bound in insert-mode that overlapped, they aren't stored anywhere else for when you disable the plugin. This means you have to re-launch vim if you want to get your defined keymaps back. This solves that issue.

Whether or not this is a waste of time, I don't care. I became more familiar with how to make things talk to one another in Neovim so that's a plus :)

## Where is prose mode?
I personally never used the prose mode, so I didn't see a purpose in porting it over. A lot of the keymaps that he uses in prose mode, I already have in my main config.
