extends StaticBody2D

var inside = 0
var open = false

func interaction_can_interact(interactionComponentParent : Node) -> bool:
	return interactionComponentParent is Lumberjack

func interaction_interact(interactionComponentParent : Node) -> void:
	if is_network_master():
		print("rpc raus")
		rpc("slave_interaction_interact",interactionComponentParent)
	print("Ich habe interagiert")
	$"../FullWall/CollisionShape2D".set_deferred("disabled", true)
	$DoorOutside.hide()
	collision_layer = collision_layer ^ 128

func _on_Area2D_body_entered(body : Node):
	if is_network_master():
		rpc("slave_on_Area2D_body_entered", body)
	print("Ich habe kjkds", body)
	if body == Player:
		inside += 1
		print(inside, "+1")
		

func _on_Area2D_body_exited(body : Node):
	if is_network_master():
		rpc("slave_on_Area2D_body_exited", body)
	print("Ich habe kjkds", body)
	if body == Player:
		inside -= 1
		print(inside, "-1")
	if inside <= 0: 
		$"../FullWall/CollisionShape2D".set_deferred("disabled", false)
		$DoorOutside.show()
		collision_layer = 128
		print("Tür Zu")



remote func slave_interaction_interact(interactionComponentParent : Node) -> void:
	print("rpc tür ")
	$"../FullWall/CollisionShape2D".set_deferred("disabled", true)
	$DoorOutside.hide()
	collision_layer = collision_layer ^ 128
		
remote func slave_on_Area2D_body_entered(body : Node):
	print("Habe rpc ", body)
	if body == Player:
		inside += 1
		print(inside, "+1")
		

remote func slave_on_Area2D_body_exited(body : Node):
	print("Habe rpc ", body)
	if body == Player:
		inside -= 1
		print(inside, "-1")
	if inside <= 0: 
		$"../FullWall/CollisionShape2D".set_deferred("disabled", false)
		$DoorOutside.show()
		collision_layer = 128
		print("Tür Zu")
			
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
