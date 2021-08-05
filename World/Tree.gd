extends StaticBody2D
var leben = 8

func _on_Hurtbox_area_entered(area):
	leben -= 1
	#emit_signal()
	if leben == 0:
		queue_free()
