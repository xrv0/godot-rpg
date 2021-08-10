extends Control

onready var animationPlayer = $AnimationPlayer

func play_animation():
	animationPlayer.play("Wood")
