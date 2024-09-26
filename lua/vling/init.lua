local M = {}
local stack = require("stackmap")
local deadkeys_mapings = require("vling.deadkeys").mappings
local ipa_mappings = require("vling.ipa").mappings

M.deadkeys = {
  state = false,
  -- Toggle the deadkey mappings with stackmap
  toggle = function ()
    if M.deadkeys.state == false then
      print('deadkeys: on')
      M.deadkeys.state = true
      stack.push("deadkeys", "i", deadkeys_mapings)
      return
    end

    if M.deadkeys.state == true then
      print('deadkeys: off')
      M.deadkeys.state = false
      stack.pop("deadkeys", "i")
      return
    end
  end
}

M.ipa = {
  state = false,
  -- Toggle the ipa mappings with stackmap
  toggle = function ()
    if M.ipa.state == false then
      print('ipa')
      M.ipa.state = true
      stack.push("ipa", "i", ipa_mappings)
      return
    end

    if M.ipa.state == true then
      print('ipa: off')
      M.ipa.state = false
      stack.pop("ipa", "i")
      return
    end
  end
}

return M
