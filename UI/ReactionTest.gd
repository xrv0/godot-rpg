extends Control

var body
var green = false

var x

func _ready():
	self.hide()

func _input(event):
	if event.is_action_pressed("ui_select"):
		if green == true:
			var n = reaction_test(body)
			n.resume()
		else:
#			$AnimationPlayer.stop()
#			$AnimationPlayer.play("ReactionBar")
			pass

func reaction_test(body : Node):
	print(body, "zuerst")
	x = body
	print("Ich mache den Test")
	self.show()
	$AnimationPlayer.play("ReactionBar")
	yield()
	print(body, "danach")
	#body.reaction_test_passed()
	
	
func green():
	green = true

func red():
	green = false
