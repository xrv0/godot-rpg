extends Control

var wood = preload("res://UI/ItemsUI/Wood.tscn")

func add_item(object):
	if object == "Wood":
		var item = wood.instance()
		add_child(item)
		item.play_animation()
