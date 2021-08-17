extends "Player.gd"

class_name StoneMason

var Items = {"stone": 0, "brick": 0,}

#StoneCutter
func check_stone():
	rpc("check_stone_4real")

remotesync func check_stone_4real():
	print(Items["stone"], " Stein")
	if Items["stone"] > 0:
		Items["brick"] = Items["stone"]
		Items["stone"] = 0
		print(Items["stone"], " Stone2")
		print(Items["brick"], " Brick")
		if is_network_master():
			get_node("/root/World/CanvasLayer/FarmedItemList").add_item("Planks")

#Chest System
func pre_stash_stone(chest : Node):
	rpc("stash_stone", chest)

remotesync func stash_stone(chest : Node):
	chest.get_stone(Items["brick"])
	
#Interaction System
func interaction_start(): #Interaction has been triggered 
	rpc("puppet_interaction_start")

func interaction_end(interaction_object):
	rpc("puppet_interaction_end", interaction_object)

func interaction_cancelled():
	state = MOVE

remotesync func puppet_interaction_end(interaction_object):
	state = MOVE
	if interaction_object == "stone":
		Items["stone"] += 1
		print(Items["stone"])

remotesync func puppet_interaction_start():
	state = INTERACTION
	


