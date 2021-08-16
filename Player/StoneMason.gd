extends "Player.gd"

class_name StoneMason


func interaction_start(): #Interaction has been triggered 
	rpc("puppet_interaction_start")

func interaction_end(interaction_object):
	rpc("puppet_interaction_end", interaction_object)

func interaction_cancelled():
	state = MOVE

remotesync func puppet_interaction_end(interaction_object):
	state = MOVE
#	if interaction_object == "tree":
#		Items["wood"] += 1
#		print(Items["wood"])

remotesync func puppet_interaction_start():
	state = INTERACTION

