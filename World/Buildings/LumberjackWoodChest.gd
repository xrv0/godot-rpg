extends StaticBody2D

var plank = 0

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	interactionComponentParent.get_parent().pre_stash_wood(self)
	
func get_wood(plank_input):
	plank = plank_input
	print(plank)
