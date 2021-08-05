extends StaticBody2D

var leben = 4

func _on_Hurtbox_area_entered(area):
	leben -= 1
	if leben == 0:
		queue_free()
