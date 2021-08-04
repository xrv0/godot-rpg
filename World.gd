extends Node2D

puppet var slave_impostor

var players = {}
var impostor



func _ready():
	slave_impostor = impostor
	if not MultiplayerHandler.is_host:
		$"CanvasLayer/START GAME!".hide()
	print("func ready (World)")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connected_to_server", self, "_connected_to_server_ok")

func _player_connected(id): #when someone else connects, I will register the player into my player list dictionary
	print("player connected (World)")
	print("Hello other players. I just connected and I wont see this message!: ", id)
	#rpc("register_player", get_tree().get_network_unique_id())
	register_player(id)
#This function not needed, just to double check ID		
func _connected_to_server_ok(): 
	print("player connected server ok (World)")	
	print("(My eyes only)I connected to the server! This is my ID: ", str(get_tree().get_network_unique_id()))	
	#rpc("register_player", get_tree().get_network_unique_id())
#	if game_started:

remote func register_player(id): 
	print("register player(World)")
	print("Everyone sees this.. adding this id to your array! ", id) # everyone sees this
	#the server will see this... better tell this guy who else is already in...
	#if !(id in players):
	players[id] = ""
	
	# Server sends the info of existing players back to the new player
	if get_tree().is_network_server():
		# Send my info to the new player
		rpc_id(id, "register_player", 1) #rpc_id only targets player with specified ID
		
		# Send the info of existing players to the new player from ther server's personal list
		for peer_id in players:
			rpc_id(id, "register_player", peer_id) #rpc_id only targets player with specified ID			
		rpc("update_player_list") # not needed, just double checks everyone on same page
#Not needed, double check everyone on sme page
remote func update_player_list():
	print("update player list(World)")
	for x in players:
		print(x)
		
#Not needed, double check everyone on sme page		
func update_player_list_local(): #when updatelist button is pressed
		for x in players:
			print(x)
#		if get_tree().is_network_server():
#			for x in players:
#				print(x)

	
remote func game_setup(): #this will setup every player instance for every player
	print("game setup(World)")
	if MultiplayerHandler.is_host:
		print("Host hats bekommen")
		rpc("game_setup")
	print("Wow2")
	$"CanvasLayer/START GAME!".hide()
	#first the host will setup the game on their end
	if get_tree().is_network_server():
		print("loading myself (World)")
#		yfor peer_id in players:                                          
#			var player_instance = load("res://Player.tscn").instance()	
#			player_instance.set_name(str(peer_id))
#			player_instance.set_network_master(peer_id)
#			get_node("/root").add_child(player_instance)
			#player_instance.playerID = str(1) 
		var player_instance = load("res://Player/Player.tscn").instance()	#dont forget to add yourself  server guy!
		player_instance.set_name(str(1))
		player_instance.set_network_master(1)
		get_node("/root/World/YSort").add_child(player_instance)
		player_instance.playerID = str(1)
		
	print("loading other peers (World)")	
	#Next evey player will spawn every other player including the server's own client! Try to move this to server only 
	for peer_id in players:
			var player_instance = load("res://Player/Player.tscn").instance()	
			player_instance.set_name(str(peer_id))			
			player_instance.set_network_master(peer_id)
			get_node("/root/World/YSort").add_child(player_instance)
			player_instance.playerID = str(peer_id)
			
	if MultiplayerHandler.is_host:
		players[1] = ""
		impostor = pick_impostor()
		rpc("impostor_picked", impostor)

remotesync func impostor_picked(wer_impostor):
	impostor = wer_impostor
	print(impostor, " das wurde von allen am Ende geprintet")
	players[impostor] = "I am impostor"
	print(players)
	game_started()
	

func game_started():
	pass
	
func pick_impostor():
	var a = players.keys()
	a = a[randi() % a.size()]
	
	print(a, " das ist der zuerst gepickte Impostor")
	return a


