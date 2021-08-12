extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	var wood_check_notifier = interactionComponentParent.get_parent()
	wood_check_notifier.check_wood()
	
	
