extends Area2D

export var interaction_parent : NodePath

signal on_interactable_changed(newInteractable)

var interaction_target : Node

func _process(delta):
	if (interaction_target != null and Input.is_action_just_pressed("interact")):
		if (interaction_target.has_method("interaction_interact")):
			interaction_target.interaction_interact(self)
		
func _on_InteractionComponent_body_entered(body):
	print("Ich habe da was berührt", body)
	var canInteract := false
	
	if (body.has_method("interaction_can_interact")):
		canInteract = body.interaction_can_interact(get_node(interaction_parent))
		print("kann interacten")
		
	if not canInteract:
		print("Kann nicht interacten")
		return
		
	interaction_target = body
	emit_signal("on_interactable_changed", interaction_target)
	
func _on_InteractionComponent_body_exited(body):
	print("Ich habe da was verlassen")
	if (body == interaction_target):
		interaction_target = null
		emit_signal("on_interactable_changed", null)
