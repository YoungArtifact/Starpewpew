extends KinematicBody2D

export (PackedScene) var laser

var speed = 150
var rotation_speed = 5

var velocity = Vector2.ZERO
var rotation_dir = 0

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("shoot"):
		shoot()

func get_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_up'):
		velocity += transform.x * speed

func shoot():
	var b = laser.instance()
	owner.add_child(b)
	b.transform = $gun.global_transform
