extends KinematicBody2D

const GRAVITY = 200.0
const WALK_SPEED = 200

var velocity = Vector2()

puppet var slave_position = Vector2()

var playerID = ""

func _ready():
	slave_position = position

func _process(delta): #change this !
	$Label.set_text(str(playerID))

func _physics_process(delta):

	#velocity.y += delta * GRAVITY
	if is_network_master(): # you on this local machine is controlling this player
		
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
		rset_unreliable("slave_position", position) # you on this local machine is telling everyone else's representation of YOU, that YOU are moving		
	else: # We are not controlling! This is a representation of this other player
		
		position = slave_position
	move_and_slide(velocity, Vector2(0, -1))
