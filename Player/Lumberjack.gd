extends "Player.gd"

class_name Lumberjack

var wood = 0

func wood_chopped():
	wood += 1
	print(wood)
