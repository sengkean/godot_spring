extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var aimPosition = get_parent().get_node("AimPosition")
onready var limitPosition = get_parent().get_node("LimitPosition")
onready var ballPosition = $BallPosition
onready var remoteTransform2D = $RemoteTransform2D

export var DEFAULT_VELOCITY = -2000
export var AIM_VELOCITY = 2500


var is_aiming = false
var ball = null
var shoot = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if ball!=null and is_aiming and !shoot:
		ball.position =  ballPosition.global_position
		
	if position.distance_to(aimPosition.position)>10:
		velocity = Vector2(0, DEFAULT_VELOCITY)
	else:
		shoot()
			
	if is_aiming:
		if position.distance_to(limitPosition.position)>10:
			velocity += Vector2(0, AIM_VELOCITY)
		else:
			velocity = Vector2.ZERO
	
	move_and_collide(velocity * delta)

	
		
func shoot():
	shoot = true
	if ball != null:
		print('shoot')
		var power = position.distance_to(aimPosition.position)
		ball.shoot(power * 10)
			
func _input(event):
	if event.is_action_pressed("ui_down"):
#		shoot = true
		is_aiming = true
#		if ball!=null:
#			print('set mass')
			
	elif event.is_action_released("ui_down"):
		is_aiming = false

#func _on_Shooter_on_shoot_release():
#	is_aiming = false
#
#	var power = position.distance_to(aimPosition.position)
#	if ball != null:
#		ball.shoot(power * 10)
#	print('release')
#
#

func _on_Area2D_body_entered(body):
	if body.is_in_group("Ball"):
		ball = body

func _on_Area2D_body_exited(body):
	if body.is_in_group("Ball"):
		ball = null
		shoot = false
		
