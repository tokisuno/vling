local M = {}
M._stack = {}
local deadkeys_mappings = require("vling.deadkeys").mappings
local ipa_mappings = require("vling.ipa").mappings

M.deadkeys = {
  state = false,
  toggle = function ()
    if M.ipa.state == true then
      print("ERR: Cannot enable Deadkeys and IPA at the same time!")
      return
    end

    if M.deadkeys.state == false then
      print("Deadkeys: ON")
      M.push("deadkeys", deadkeys_mappings)
      M.deadkeys.state = true
      return
    end

    if M.deadkeys.state == true then
      print("Deadkeys: OFF")
      M.pop("deadkeys")
      M.deadkeys.state = false
      return
    end
  end
}

M.ipa = {
  state = false,
  toggle = function ()
    if M.deadkeys.state == true then
      print("ERR: Cannot enable IPA and Deadkeys at the same time!")
      return
    end

    if M.ipa.state == false then
      print("IPA: ON")
      M.push("ipa", ipa_mappings)
      M.ipa.state = true
      return
    end

    if M.ipa.state == true then
      print("IPA: OFF")
      M.pop("ipa")
      M.ipa.state = false
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

M.push = function (name, mappings)
  local maps = vim.api.nvim_get_keymap('i')

  local existing_maps = {}
  for lhs, rhs in pairs(mappings) do
    local existing = find_mapping(maps, lhs)
    if existing then
      existing_maps[lhs] = existing
    end
  end

  for lhs, rhs in pairs(mappings) do
    local opts = {
      desc = 'Input ['..rhs..']',
      silent = false,
    }
    vim.keymap.set('i', lhs, rhs, opts)
  end

  M._stack[name] = M._stack[name] or {}

  M._stack[name]['i'] = {
    existing = existing_maps,
    mappings = mappings,
  }
end

M.pop = function (name)
  local state = M._stack[name]['i']
  M._stack[name]['i'] = nil

  for lhs, rhs in pairs(state.mappings) do
    if state.existing[lhs] then
      local og_mapping = state.existing[lhs]
      vim.keymap.set('i', lhs, og_mapping.rhs)
    else
      vim.keymap.del('i', lhs)
    end
  end
end

M._clear = function () M._stack = {} end

return M
