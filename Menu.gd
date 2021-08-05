extends Node2D

var players = {}

onready var ip_enter = $IP_enter
onready var enter_IP_Label = $Enter_IP_Label

func _ready():
	print("func ready (Menu)")
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connected_to_server", self, "_connected_to_server_ok")
	
func host_server():	
	print("hosting server (Menu)")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(4242, 10)
	get_tree().set_network_peer(peer)
	#checks:
	print("Hosting...This is my ID: ", str(get_tree().get_network_unique_id()))
	load_lobby()
	MultiplayerHandler.is_host = true
	
	#load_players()

func join_server():
	print("joining server (Menu)")
	var peer_join = NetworkedMultiplayerENet.new()
	peer_join.create_client(ip_enter.text, 4242) #82.82.55.60 #127.0.0.1 #2.206.205.151
	get_tree().set_network_peer(peer_join)	
	#checks:
	print("Joining...This is my ID: ", str(get_tree().get_network_unique_id())) 
	load_lobby()
	#load_players()
	MultiplayerHandler.is_host = false
	
func load_lobby():
	print("load lobby (Menu)")
	get_tree().change_scene("res://World.tscn")

	
#func _player_connected(id): #when someone else connects, I will register the player into my player list dictionary
#	print("player connected")
#	print("Hello other players. I just connected and I wont see this message!: ", id)
#	#rpc("register_player", get_tree().get_network_unique_id())
#	register_player(id)
##This function not needed, just to double check ID		
#func _connected_to_server_ok(): 
#	print("player connected to server ok")		
#	print("(My eyes only)I connected to the server! This is my ID: ", str(get_tree().get_network_unique_id()))	
#	#rpc("register_player", get_tree().get_network_unique_id())
##	if game_started:
#
#remote func register_player(id): 
#	print("register Player")
#	print("Everyone sees this.. adding this id to your array! ", id) # everyone sees this
#	#the server will see this... better tell this guy who else is already in...
#	#if !(id in players):
#	players[id] = ""
#
#	# Server sends the info of existing players back to the new player
#	if get_tree().is_network_server():
#		# Send my info to the new player
#		rpc_id(id, "register_player", 1) #rpc_id only targets player with specified ID
#
#		# Send the info of existing players to the new player from ther server's personal list
#		for peer_id in players:
#			rpc_id(id, "register_player", peer_id) #rpc_id only targets player with specified ID			
#		rpc("update_player_list") # not needed, just double checks everyone on same page
##Not needed, double check everyone on sme page
#remote func update_player_list():
#	print("updating player list")
#	for x in players:
#		print(x)
#
##Not needed, double check everyone on sme page		
#func update_player_list_local(): #when updatelist button is pressed
#		for x in players:
#			print(x)
##		if get_tree().is_network_server():
##			for x in players:
##				print(x)
#
#
#
##Vanilla game setup function
##func game_setup(): #this will setup every player instance for every player
##	$"START GAME!".hide()
##	#first the host will setup the game on their end
##	if get_tree().is_network_server(): 	
###		for peer_id in players:                                          
###			var player_instance = load("res://Player.tscn").instance()	
###			player_instance.set_name(str(peer_id))
###			player_instance.set_network_master(peer_id)
###			get_node("/root").add_child(player_instance)
##			#player_instance.playerID = str(1) 
##		var player_instance = load("res://Player/Player.tscn").instance()	#dont forget to add yourself  server guy!
##		player_instance.set_name(str(1))
##		player_instance.set_network_master(1)
##		get_node("/root").add_child(player_instance)
##		player_instance.playerID = str(1) 
##
##	#Next evey player will spawn every other player including the server's own client! Try to move this to server only 
##	for peer_id in players:
##			var player_instance = load("res://Player/Player.tscn").instance()	
##			player_instance.set_name(str(peer_id))			
##			player_instance.set_network_master(peer_id)
##			get_node("/root").add_child(player_instance)
##			player_instance.playerID = str(peer_id) 
#
