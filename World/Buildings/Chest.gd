extends StaticBody2D

export var class_type = 'StoneMason'

var type = StoneMason
var inventory = 0

func _ready():
	if class_type == 'StoneMason':
		$Sprite.set_frame(1)
		type = StoneMason
	if class_type == 'Lumberjack':
		$Sprite.set_frame(0)
		type = Lumberjack

func interaction_can_interact(interactionComponentParent : Node) -> bool:
		return interactionComponentParent is type
	

func interaction_interact(interactionComponentParent : Node) -> void:
	interactionComponentParent.get_parent().pre_stash_stone(self)
	
func get_stone(input):
	inventory = input
	print(inventory)
