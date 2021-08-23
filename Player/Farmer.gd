extends "Player.gd"

class_name Farmer

var Items = {"resource1": 0, "resource2": 0,}

#StoneCutter
func check_resource1():
	rpc("check_resource14real")

remotesync func check_resource14real():
	print(Items["resource1"], " Resource1")
	if Items["resource1"] > 0:
		Items["resource2"] = Items["resource1"]
		Items["resource1"] = 0
		print(Items["resource1"], " Stone2")
		print(Items["resource2"], " Brick")
		if is_network_master():
			get_node("/root/World/CanvasLayer/FarmedItemList").add_item("Planks")

#Chest System
func pre_stash_stone(chest : Node):
	rpc("stash_stone", chest)

remotesync func stash_stone(chest : Node):
	chest.get_stone(Items["resource1"])
	
#Interaction System
func interaction_start(): #Interaction has been triggered 
	rpc("puppet_interaction_start")

func interaction_end(interaction_object):
	rpc("puppet_interaction_end", interaction_object)

func interaction_cancelled():
	state = MOVE

remotesync func puppet_interaction_end(interaction_object):
	state = MOVE
	if interaction_object == "resource1":
		Items["resource1"] += 1
		print(Items["resource1"])

remotesync func puppet_interaction_start():
	state = INTERACTION
	


