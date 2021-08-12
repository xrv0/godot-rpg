extends Control

var wood = preload("res://UI/ItemsUI/Wood.tscn")
var planks = preload("res://UI/ItemsUI/Plank.tscn")

func add_item(object):
	if object == "Wood":
		var item = wood.instance()
		add_child(item)
		item.play_animation()
	if object == "Planks":
		var item = planks.instance()
		add_child(item)
		item.play_animation()
		

