

local q = game.player:hasQuest("double-macguffin")
local set = function(what) return function(npc, player) q:setStatus(q.COMPLETED, "chat-"..what) end end
local isNotSet = function(what) return function(npc, player) return not q:isCompleted("chat-"..what) end end

local qe = game.player:hasQuest("elemental-quests")
local isDone = function(what) return function(npc, player) return q:isCompleted(what.."-quest") end end

newChat {
	id = "start",
	text = [[You have come.]],
	answers = {
	{"How can I help?", jump="help", cond=isNotSet"help", action=set"help"},
	{"I have stolen the Gravity Lens from Murmon", jump="post-earth", cond=isDone"earth"},
	{"[leave]"},
	},
}

newChat {
	id = "help",
	text = [[Go do the elemental quests. Start at Murmon, in the middle of this land.]],
	answers = {
	{"Fine.", action=function(npc, player) player:grantQuest("elemental-quests") end },
	},
}

newChat {
	id = "post-earth",
	text = [[(She frowns.)
Stolen?  You should not have have had to steal it.]],
	answers = {
	{"How do I do fire?", jump="tomb"},
	},
}

newChat {
	id = "tomb",
	text = [[The volcano Name is no longer accessible ... by land.  But there is a way.  It is a dark and dangerous way, however.

The makers of Susrak's Cage made a secret path to the depths of X.  I will mark the entrance on your map.

Be warned: the Cage is not a quiet resting place.  Pass through the atrium, quickly and quietly, and do not enter the tomb of that fell sorceror.]],
	answers = {
	{"Um, got it.", action=function(npc, player) player:setQuestStatus("elemental-quests", engine.Quest.PENDING, "tomb") end },
	},
}

return "start"
