extends StaticBody2D

var interaction_ongoing = false
var a #interactionComponentParentsParent
class_name tree

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	if interaction_ongoing == false:
		interaction_ongoing = true
	a = interactionComponentParent.get_parent()
	a.interaction_start() #Tell Player that interaction started an pass on own Node
		#Jetzt den Reaktionstest callen und die eigene Node weiterreichen
	get_node("/root/World/CanvasLayer/ReactionTest").start_test(get_node("."))
	
func reaction_test_passed():
	interaction_ongoing = false
	a.interaction_end("tree") #Inform the player that the interaction has ended
	queue_free()

func reaction_test_cancelled(): #Inform the player that the interaction has been cancelled
	interaction_ongoing = false
	a.interaction_cancelled()
