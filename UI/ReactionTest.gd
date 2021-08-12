extends Control

var current_body
var green = false

var x

func _ready():
	self.hide()



func _input(event):
	if event.is_action_pressed("ui_select"):
		if green == true:
			current_body.reaction_test_passed()
			$AnimationPlayer.stop()
			hide()
		else:
			$AnimationPlayer.stop()
			$AnimationPlayer.play("ReactionBar")

func reaction_test(body : Node):
	#print(body, "zuerst")
	current_body = body
	self.show()
	$AnimationPlayer.play("ReactionBar")
	print(current_body)
	#body.reaction_test_passed()
	
	
func green():
	green = true

func red():
	green = false
