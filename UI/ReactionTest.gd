extends Control

var green = false
var red = true

func reaction_test():
	$AnimationPlayer.play("ReactionBar")
	
func green():
	green = true

func red():
	red = true
