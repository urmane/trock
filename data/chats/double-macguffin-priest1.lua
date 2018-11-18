
--local q = game.player:hasQuest("double-macguffin")
--local set = function(what) return function(npc, player) q:setStatus(q.COMPLETED, "chat-"..what) end end
--local isNotSet = function(what) return function(npc, player) return not q:isCompleted("chat-"..what) end end

newChat {
	id = "start",
	text = [[The priest looks at you, and is not impressed.

"How may I be of assistance?"]],
	answers = {
	{"I'm looking for Latiyus, his father gave me this necklace to deliver.", jump="help"},
	},
}

newChat {
	id = "help",
	text = [[The priest goes white.

"The Son!"]],
	answers = {
	{"Yes, the son.  Where can I find him?", jump="where"},
	},
}

newChat {
	id = "where",
	text = [[The priest points, trembling.

"In the graveyard ... go to the oldest stone ..."

The man falls to his knees and bows before you.]],
	answers = {
	{"Uh, thanks.", action=function(npc, player) player:setQuestStatus("double-macguffin",engine.Quest.COMPLETED) end},
	},
}

return "start"
