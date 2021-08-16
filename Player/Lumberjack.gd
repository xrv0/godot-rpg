extends "Player.gd"

class_name Lumberjack


func _ready():
	animationTree.active = true

var Items = {"wood": 0, "plank": 0,}

func wood_chopped():
	Items["wood"] += 1
	print(Items["wood"])

func check_wood():
	rpc("check_wood_4real")

remotesync func check_wood_4real():
	print(Items["wood"], " Holz")
	if Items["wood"] > 0:
		Items["plank"] = Items["wood"]
		Items["wood"] = 0
		print(Items["wood"], " Holz2")
		print(Items["plank"], " Planken")
		if is_network_master():
			get_node("/root/World/CanvasLayer/FarmedItemList").add_item("Planks")
	else:
		print("Du hast kein Holz")

func pre_stash_wood(chest : Node):
	rpc("stash_wood", chest)

remotesync func stash_wood(chest : Node):
	chest.get_wood(Items["plank"])

func interaction_start(): #Interaction has been triggered 
	rpc("puppet_interaction_start")

func interaction_end(interaction_object):
	rpc("puppet_interaction_end", interaction_object)

func interaction_cancelled():
	state = MOVE

remotesync func puppet_interaction_end(interaction_object):
	state = MOVE
	if interaction_object == "tree":
		Items["wood"] += 1
		print(Items["wood"])

remotesync func puppet_interaction_start():
	state = INTERACTION

#
