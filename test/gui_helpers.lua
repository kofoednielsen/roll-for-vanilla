local M = {}

local transformer = require( "src/RollingPopupContentTransformer" )
local button_definitions = transformer.button_definitions

local T = require( "src/Types" )
local RT = T.RollType

---@param item DroppedItem
---@param item_count number
---@param padding number?
function M.item_link( item, item_count, padding )
  return { type = "item_link_with_icon", link = item.link, tooltip_link = item.tooltip_link, count = item_count, padding = padding or 5 }
end

---@param player Player
---@param roll_type RollType
---@param padding number?
function M.roll_placeholder( player, roll_type, padding, plus_ones )
  return { type = "roll", player_name = player.name, player_class = player.class, roll_type = roll_type, padding = padding, plus_ones = plus_ones }
end

---@param player Player
---@param padding number?
function M.sr_roll_placeholder( player, padding )
  return M.roll_placeholder( player, RT.SoftRes, padding )
end

---@param player Player
---@param padding number?
function M.mainspec_roll( player, roll, padding, plus_ones )
  return { type = "roll", player_name = player.name, player_class = player.class, roll_type = RT.MainSpec, roll = roll, padding = padding, plus_ones = plus_ones }
end

---@param player Player
---@param padding number?
function M.offspec_roll( player, roll, padding, plus_ones )
  return { type = "roll", player_name = player.name, player_class = player.class, roll_type = RT.OffSpec, roll = roll, padding = padding, plus_ones = plus_ones }
end

---@param player Player
---@param padding number?
function M.tmog_roll( player, roll, padding, plus_ones )
  return { type = "roll", player_name = player.name, player_class = player.class, roll_type = RT.Transmog, roll = roll, padding = padding, plus_ones = plus_ones }
end

---@param player Player
---@param padding number?
function M.softres_roll( player, roll, padding, plus_ones )
  return { type = "roll", player_name = player.name, player_class = player.class, roll_type = RT.SoftRes, roll = roll, padding = padding, plus_ones = plus_ones }
end

---@param message string
---@param padding number?
function M.text( message, padding ) return { type = "text", value = message, padding = padding } end

---@param height number
---@param padding number?
function M.empty_line( height, padding ) return { type = "empty_line", height = height, padding = padding } end

---@param index number
---@param name string
---@param comment string?
---@param comment_tooltip string[]?
---@param bind string?
function M.enabled_item( index, name, comment, comment_tooltip, bind )
  return { index = index, is_enabled = true, is_selected = false, name = name, comment = comment, comment_tooltip = comment_tooltip, bind = bind }
end

---@param index number
---@param name string
---@param comment string?
---@param comment_tooltip string[]?
---@param bind string?
function M.disabled_item( index, name, comment, comment_tooltip, bind )
  return { index = index, is_enabled = false, is_selected = false, name = name, comment = comment, comment_tooltip = comment_tooltip, bind = bind }
end

---@param index number
---@param name string
---@param comment string?
---@param comment_tooltip string[]?
---@param bind string?
function M.selected_item( index, name, comment, comment_tooltip, bind )
  return { index = index, is_enabled = true, is_selected = true, name = name, comment = comment, comment_tooltip = comment_tooltip, bind = bind }
end

---@param ... RollingPopupButtonType
function M.buttons( ... )
  local result = {}

  for _, button_type in ipairs( { ... } ) do
    local button = button_definitions[ button_type ]
    if not button then error( string.format( "%s button definition was not found.", button_type ), 2 ) end

    table.insert( result, button_definitions[ button_type ] )
  end

  return table.unpack( result )
end

M.individual_award_button = { type = "award_button", label = "Award", width = 90, padding = 6 }

return M
