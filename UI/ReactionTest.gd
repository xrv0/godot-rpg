extends Control

var rng = RandomNumberGenerator.new()

var caller
var test_ongoing = false
var green = false

func _input(event):
	if test_ongoing == true:
		if event.is_action_pressed("ui_select"):
			if green == true:
				test_ongoing = false
				caller.reaction_test_passed() #Return that the test was passed
				self.hide()
				$AnimationPlayer.stop()
			else:
				rng.randomize()
				var my_random_number = rng.randf_range(-10.0, 10.0)
				$AnimationPlayer.stop()
				$AnimationPlayer.play("ReactionBar")
				$AnimationPlayer.seek(my_random_number)
			
		if event.is_action_pressed("ui_cancel"):
			test_ongoing = false
			caller.reaction_test_cancelled() #Return that the test cancelled
			self.hide
			$AnimationPlayer.hide()
			

func start_test(object : Node):
	if test_ongoing == false:
		rng.randomize()
		var my_random_number = rng.randf_range(-10.0, 10.0)
		caller = object
		test_ongoing = true
		self.show()
		$AnimationPlayer.play("ReactionBar")
		$AnimationPlayer.seek(my_random_number)
	
func green():
	green = true

func red():
	green = false
