extends "Player.gd"

class_name Lumberjack

var Items = {"wood": 0}

func wood_chopped():
	Items["wood"] += 1
	print(Items["wood"])

