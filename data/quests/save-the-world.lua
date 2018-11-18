
name = "Save The World!"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "You must save the world."
	if self:isCompleted() then
		desc[#desc+1] = "#LIGHT_GREEN#* You have won the game!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must save the world.#WHITE#"
	end
	return table.concat(desc, "\n")
end

on_grant = function(self, who)
end

on_status_change = function(self, who, status, sub)
	if sub then
		if not self:isCompleted() then
			who:setQuestStatus(self.id, engine.Quest.COMPLETED)
            -- notify the userchat
            --local Chat = require"engine.Chat"
            --local chat = Chat.new("winner", {name="Endgame"}, game:getPlayer(true))
            --chat:invoke()
            -- Gain achievement
            world:gainAchievement("WIN", game.player)
            -- check all items
            local p = game:getPlayer(true)
            p:inventoryApplyAll(function(inven, item, o) o:check("on_win") end)
            --game:registerDialog(require("engine.dialogs.ShowText").new("Winner", "win", {playername=p.name}, game.w * 0.6))
            --game:saveGame()
		end
	end
end
