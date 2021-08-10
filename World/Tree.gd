extends StaticBody2D

class_name tree

var leben = 4

func _on_Hurtbox_area_entered(area):
	leben -= 1
	if leben == 0:
		queue_free()

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	if is_network_master():
		
		get_node("/root/World/CanvasLayer/FarmedItemList").add_item("Wood")
		
	var a = interactionComponentParent.get_parent()
	a.wood_chopped()
	leben -= 1
	if leben == 0:
		queue_free()
		
