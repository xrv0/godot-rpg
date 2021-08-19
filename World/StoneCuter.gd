extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is StoneMason

func interaction_interact(interactionComponentParent : Node) -> void:
	interactionComponentParent.get_parent().check_stone()
