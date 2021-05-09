extends RigidBody2D

var velocity = Vector2.ZERO
var is_aiming = false

func _process(delta):
	velocity = Vector2(0, -500)
	if is_aiming:
		velocity = Vector2(0, 50)
	apply_central_impulse(velocity)
	
func _input(event):
	if event.is_action_pressed("ui_down"):
		is_aiming = true
	elif event.is_action_released("ui_down"):
		is_aiming = false
		
