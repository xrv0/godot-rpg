extends Control

var current_body
var green = false

var x
var y = 1

func _ready():
	self.hide()

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_select"):
		if green == true:
			if y % 4 != 0:
				print(y)
				current_body.reaction_test_passed()
				$AnimationPlayer.stop()
				$AnimationPlayer.play("ReactionBar")
				y += 1
			else:
				current_body.reaction_test_passed()
				print(y)
				$AnimationPlayer.stop()
				self.hide()
				y = 1
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
