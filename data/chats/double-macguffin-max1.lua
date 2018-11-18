
--local q = game.player:hasQuest("double-macguffin")
--local set = function(what) return function(npc, player) q:setStatus(q.COMPLETED, "chat-"..what) end end
--local isNotSet = function(what) return function(npc, player) return not q:isCompleted("chat-"..what) end end

newChat {
	id = "start",
	text = [[What do you want?]],
	answers = {
	{"Your father gave me this neclace", jump="help"},
	{"Just die.", jump="nohelp"},
	},
}

newChat {
	id = "help",
	text = [[Thanks for this!]],
	answers = {
	{"No problem", action=function(npc, player) player:setQuestStatus("double-macguffin",engine.Quest.COMPLETED) end },
	},
}

newChat {
	id = "nohelp",
	text = [[Well, you're not very nice.]],
	answers = {
	{"<stick out tongue>"},
	},
}

return "start"
