extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	interactionComponentParent.get_parent().check_wood()
