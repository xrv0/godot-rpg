extends Node2D

func _ready():
	$Full/HouseFull.show()
	$Full/HouseFull.show()

func _on_Area2D_body_entered(body : Node):
	print("MeunIch habe ", body)
	if check_body(body):
	#if body == Player:
		$Full/HouseFull.hide()


func _on_Area2D_body_exited(body : Node):
	print("MeunIch habe ", body)
	#if body == Player:
	if check_body(body):
		$Full/HouseFull.show()

func check_body(body):
	return body # hier fixern

#if inside:
#		$"../Full/OpenDoorHouseFull".show()
#		$"../FullWall/CollisionShape2D".set_deferred("disabled", true)
#		$Sprite.hide()
#		if timer_started == false:
#			print("Timer gestarted")
#			timer_started = true
#			var timer = Timer.new()
#			timer.connect("timeout",self,"_on_timer_timeout") 
#			add_child(timer)
#			timer.start(4)
#
#	else:
#		$"../Full/HouseFull".hide()
#		$"../Full/OpenDoorHouseFull".hide()
#		$Sprite.hide()
#		if timer_started == false:
#			print("Timer gestarted")
#			timer_started = true
#			var timer = Timer.new()
#			timer.connect("timeout",self,"_on_timer_timeout") 
#			add_child(timer)
#			timer.start(3)
#			$"../FullWall/CollisionShape2D".set_deferred("disabled", true)
#			#collision_layer = collision_layer ^ 128
#
#func _on_timer_timeout():
#	$"../FullWall/CollisionShape2D".set_deferred("disabled", false)
#	if inside:
#		$"../Full/HouseFull".show()
#	else:
#		$Sprite.show()
#	timer_started = false


