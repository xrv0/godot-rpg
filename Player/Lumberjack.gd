extends "Player.gd"

class_name Lumberjack


func _ready():
	animationTree.active = true

var Items = {"wood": 0, "plank": 0,}

func wood_chopped():
	Items["wood"] += 1
	print(Items["wood"])

func check_wood():
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

func interaction_start(): #Interaction has been triggered 
	state = INTERACTION
#
func interaction_end(interaction_object):
	state = MOVE
	if interaction_object == "tree":
		Items["wood"] += 1
		print(Items["wood"])

#
#func interaction_cancelled():
##	state = MOVE
#
