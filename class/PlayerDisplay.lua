require "engine.class"

module(..., package.seeall, class.make)

function _M:init(x, y, w, h, bgcolor, font, size)
    self.display_x = x
    self.display_y = y
    self.w, self.h = w, h
    self.bgcolor = bgcolor
    self.font = core.display.newFont(font, size)
    self:resize(x, y, w, h)
end

--- Resize the display area
function _M:resize(x, y, w, h)
    self.display_x, self.display_y = x, y
    self.w, self.h = w, h
    self.font_h = self.font:lineSkip()
    self.font_w = self.font:size(" ")
    self.bars_x = self.font_w * 9
    self.bars_w = self.w - self.bars_x - 5
    self.surface = core.display.newSurface(w, h)
    self.surface_line = core.display.newSurface(w, self.font_h)
    self.texture = self.surface:glTexture()

    self.items = {}
end

function _M:makeTexture(text, x, y, r, g, b, max_w)
    local s = self.surface_line
    s:erase(0, 0, 0, 0)
    s:drawColorStringBlended(self.font, text, 0, 0, r, g, b, true, max_w)

    local item = { s:glTexture() }
    item.x = x
    item.y = y
    item.w = self.w
    item.h = self.font_h
    self.items[#self.items+1] = item

    return item.w, item.h, item.x, item.y
end

function _M:makeTextureBar(text, nfmt, val, max, reg, x, y, r, g, b, bar_col, bar_bgcol)
    local s = self.surface_line
    s:erase(0, 0, 0, 0)
    s:erase(bar_bgcol.r, bar_bgcol.g, bar_bgcol.b, 255, self.bars_x, h, self.bars_w, self.font_h)
    s:erase(bar_col.r, bar_col.g, bar_col.b, 255, self.bars_x, h, self.bars_w * val / max, self.font_h)

    s:drawColorStringBlended(self.font, text, 0, 0, r, g, b, true)
    s:drawColorStringBlended(self.font, (nfmt or "%d/%d"):format(val, max), self.bars_x + 5, 0, r, g, b)
    if reg and reg ~= 0 then
        local reg_txt = (" (%s%.2f)"):format((reg > 0 and "+") or "",reg)
        local reg_txt_w = self.font:size(reg_txt)
        s:drawColorStringBlended(self.font, reg_txt, self.bars_x + self.bars_w - reg_txt_w - 3, 0, r, g, b)
    end
    local item = { s:glTexture() }
    item.x = x
    item.y = y
    item.w = self.w
    item.h = self.font_h
    self.items[#self.items+1] = item

    return item.w, item.h, item.x, item.y
end

-- Displays the stats
function _M:display()
    local player = game.player
    if not player or not player.changed or not game.level then return end

    self.items = {}

    local h = 6
    local x = 2
    
    self.font:setStyle("bold")
    self:makeTexture(("%s#{normal}#"):format(player.name), 0, h, colors.GOLD.r, colors.GOLD.g, colors.GOLD.b, self.w)
    h = h + self.font_h
    self.font:setStyle("normal")

    self:makeTexture(("Str/Dex/Sns: #00ff00#%3d/%3d/%3d"):format(player:getStr(), player:getDex(), player:getSns()), x, h, 255, 255, 255)
    h = h + self.font_h
    self:makeTexture(("Cog/Rct/Chr: #00ff00#%3d/%3d/%3d"):format(player:getCog(), player:getRct(), player:getChr()), x, h, 255, 255, 255)
    h = h + self.font_h
    self:makeTexture(("Wil/Att/Lck: #00ff00#%3d/%3d/%3d"):format(player:getWil(), player:getAtt(), player:getLck()), x, h, 255, 255, 255)
    h = h + self.font_h
    self:makeTexture(("Level/Exp: #00ff00#%3d/%3d"):format(player.level or 1, player.exp or 0), x, h, 255, 255, 255)
    h = h + self.font_h

   -- spacer 
   h = h + self.font_h

    self:makeTextureBar("#c00000#Life:", nil, player.life, player.max_life, player.life_regen * util.bound((player.healing_factor or 1), 0, 2.5), x, h, 255, 255, 255, colors.DARK_RED, colors.VERY_DARK_RED)
    h = h + self.font_h

    self:makeTextureBar("#c00000#Breath:", nil, player.breath, player.max_breath, player.breath_regen, x, h, 255, 255, 255, colors.DARK_BLUE, colors.DARK_BLUE)
    h = h + self.font_h

    self:makeTextureBar("#ffcc80#Earth:", nil, player:getEarth(), player.max_power, player.power_regen, x, h, 255, 255, 255, colors.UMBER, {r=colors.UMBER.r/2, g=colors.UMBER.g/2, b=colors.UMBER.b/2})
    h = h + self.font_h

    self:makeTextureBar("#ffcc80#Air:", nil, player:getAir(), player.max_power, player.power_regen, x, h, 0, 0, 0, colors.YELLOW, {r=colors.YELLOW.r/2, g=colors.YELLOW.g/2, b=colors.YELLOW.b/2})
    h = h + self.font_h

    self:makeTextureBar("#ffcc80#Fire:", nil, player:getFire(), player.max_power, player.power_regen, x, h, 255, 255, 255, colors.RED, {r=colors.RED.r/2, g=colors.RED.g/2, b=colors.RED.b/2})
    h = h + self.font_h

    self:makeTextureBar("#ffcc80#Water:", nil, player:getWater(), player.max_power, player.power_regen, x, h, 255, 255, 255, colors.DARK_BLUE, {r=colors.DARK_BLUE.r/2, g=colors.DARK_BLUE.g/2, b=colors.DARK_BLUE.b/2})
    h = h + self.font_h

   -- spacer 
   h = h + self.font_h

    self:makeTextureBar("#ffcc80#Gold:", nil, player:getGold(), player.max_gold, 0, x, h, 0, 0, 0, colors.GOLD, {r=colors.GOLD.r/2, g=colors.GOLD.g/2, b=colors.GOLD.b/2})
    h = h + self.font_h

--    self:makeTextureBar("#ffcc80#Power:", nil, player:getPower(), player.max_power, player.power_regen, x, h, 255, 255, 255, colors.DARK_BLUE, {r=colors.DARK_BLUE.r/2, g=colors.DARK_BLUE.g/2, b=colors.DARK_BLUE.b/2})
--    h = h + self.font_h

    if savefile_pipe.saving then
        h = h + self.font_h
        self:makeTextureBar("Saving:", "%d%%", 100 * savefile_pipe.current_nb / savefile_pipe.total_nb, 100, nil, x, h, colors.YELLOW.r, colors.YELLOW.g, colors.YELLOW.b, 
        {r=49, g=54,b=42},{r=17, g=19, b=0})

        h = h + self.font_h
    end

end

function _M:toScreen(nb_keyframes)
    self:display()
    
    core.display.drawQuad(self.display_x, self.display_y, self.w, self.h, 100,100,100, 200)
    
    for i = 1, #self.items do
        local item = self.items[i]
        if type(item) == "table" then
            if item.glow then
                local glow = (1+math.sin(core.game.getTime() / 500)) / 2 * 100 + 120
                item[1]:toScreenFull(self.display_x + item.x, self.display_y + item.y, item.w, item.h, item[2], item[3], 1, 1, 1, glow / 255)
            else
                item[1]:toScreenFull(self.display_x + item.x, self.display_y + item.y, item.w, item.h, item[2], item[3])
            end
        else
            item(self.display_x, self.display_y)
        end
    end

end

