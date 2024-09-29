local M = {}
local deadkeys_mappings = require("vling.deadkeys").mappings
local ipa_mappings = require("vling.ipa").mappings

M.deadkeys = {
  state = false,
  -- Toggle the deadkey mappings with stackmap
  toggle = function ()
    if M.deadkeys.state == false then
      print("Deadkeys: ON")
      M.push("deadkeys", deadkeys_mappings)
      return
    end

    if M.deadkeys.state == true then
      print("Deadkeys: OFF")
      M.pop("deadkeys")
      return
    end
  end
}

M.ipa = {
  state = false,
  -- Toggle the ipa mappings with stackmap
  toggle = function ()
    if M.ipa.state == false then
    end

    if M.ipa.state == true then
    end
  end
}

local find_mapping = function(maps, lhs)
  for _, value in ipairs(maps) do
    if value.lhs == lhs then
      return value
    end
  end
end

M._stack = {}

M.push = function (name, mappings)
  local maps = vim.api.nvim_get_keymap('ia')

  local existing_maps = {}
  for lhs, rhs in pairs(mappings) do
    local existing = find_mapping(maps, lhs)
    if existing then
      existing_maps[lhs] = existing
    end
  end

  for lhs, rhs in pairs(mappings) do
    vim.keymap.set('ia', lhs, rhs, { desc = rhs })
  end

  M._stack[name] = M._stack[name] or {}

  M._stack[name]['ia'] = {
    existing = existing_maps,
    mappings = mappings,
  }
end

M.pop = function (name)
  local state = M._stack[name]['ia']
  M._stack[name]['ia'] = nil

  for lhs, rhs in pairs(state.mappings) do
    if state.existing[lhs] then
      local og_mapping = state.existing[lhs]
      vim.keymap.set('ia', lhs, og_mapping.rhs)
    else
      vim.keymap.del('ia', lhs)
    end
  end
end

M._clear = function ()
  M._stack = {}
end

return M
