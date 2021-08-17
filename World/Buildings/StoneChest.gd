extends StaticBody2D

var brick = 0

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is StoneMason

func interaction_interact(interactionComponentParent : Node) -> void:
	interactionComponentParent.get_parent().pre_stash_stone(self)
	
func get_stone(stone_input):
	brick = stone_input
	print(brick)
