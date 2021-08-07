extends StaticBody2D

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	$"../Full/HouseFull".hide()
	$"../FullWall/CollisionShape2D".set_deferred("disabled", true)
	
