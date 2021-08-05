extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var stats = PlayerStats
var input_vector = Vector2.ZERO

puppet var slave_position = Vector2() 
puppet var slave_frame = 1
puppet var slave_input_vector = Vector2.ZERO
#puppet var slave_input_vector = Vector2()
var playerID = ""

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwortHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer
onready var sprite = $Sprite
	
func _ready():
	#if is_network_master():
	self.global_transform.origin.x = 160
	self.global_transform.origin.y = 88
	animationTree.active = true
	
	slave_position = position
	#slave_frame = sprite.frame
	#slave_input_vector = input_vector
	randomize()
	stats.connect("no_health", self, "queue_free")
	swordHitbox.knockback_vector = roll_vector
	if is_network_master():
		$RemoteTransform2D.set_remote_node("../../../Camera2D")

func _physics_process(delta):
	#if is_network_master():
	match state:
			MOVE:
				move_state(delta)
			ROLL:
				roll_state()
			ATTACK:
				attack_state()
				
		
		#rset_unreliable("slave_frame", sprite.frame)
	if is_network_master():
		rset_unreliable("slave_position", position)
		#rset_unreliable("slave_input_vector", input_vector)
		
		
	else:
		position = slave_position
		#input_vector = slave_input_vector
		#sprite.frame = slave_frame
	


func move_state(delta):
	
	if is_network_master():
		slave_input_vector = Vector2.ZERO
		input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		rset("slave_input_vector", input_vector)
	else:
		input_vector = slave_input_vector
		
	input_vector = input_vector.normalized()
	#rset_unreliable("slave_input_vector", input_vector)
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		#rpc_unreliable("puppet_animation", "Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)


	else:
		animationState.travel("Idle")
		#rpc_unreliable("puppet_animation", "Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

		
	move()
	if is_network_master():
		if Input.is_action_just_pressed("roll"):
			state = ROLL
			rpc_unreliable("puppet_is_action_just_pressed", ROLL)
	
		if Input.is_action_just_pressed("attack"):
			state = ATTACK
			rpc_unreliable("puppet_is_action_just_pressed", ATTACK)

remote func puppet_is_action_just_pressed(state_transition):
	if not is_network_master():
		state = state_transition


func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	#rpc_unreliable("puppet_animation", "Roll")
	move()	

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	#rpc_unreliable("puppet_animation", "Attack")
	#puppet_animation("Attack")
	
		
#remote func puppet_animation(animation_type):
#	if not is_network_master():
#		animationState.travel(animation_type)


func move():
	velocity = move_and_slide(velocity)
	
	
func roll_animation_finished():
	velocity = velocity * 0.8
	state = MOVE
	
func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(area):
	if is_network_master():
		stats.health -= area.damage
		hurtbox.start_invincibility(0.6)
		hurtbox.create_hit_effect()
		var playerHurtSound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	if is_network_master():
		blinkAnimationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	if is_network_master():
		blinkAnimationPlayer.play("Stop")
