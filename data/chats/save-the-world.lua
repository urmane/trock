
--local q = game.player:hasQuest("double-macguffin")
--local set = function(what) return function(npc, player) q:setStatus(q.COMPLETED, "chat-"..what) end end
--local isNotSet = function(what) return function(npc, player) return not q:isCompleted("chat-"..what) end end

newChat {
	id = "start",
	text = [[You should probably save the world.]],
	answers = {
	{"OK!", jump="save"},
	},
}

newChat {
	id = "save",
	text = [[Go now!]],
	answers = {
	{"<go>", action=function(npc, player) player:grantQuest("save-the-world") end },
	},
}

return "start"
