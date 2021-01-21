extends Area2D

var playership = preload("res://scenes/Playership.tscn")

var speed = 100
var velocity = Vector2.ZERO
var player = null
var steer_force = 50.0
var acceleration = Vector2.ZERO
var screen = Vector2()

var random = RandomNumberGenerator.new()

func _ready():
	randomize()

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle()
	position += velocity * delta

func start(_transform, _player):
	global_transform = _transform
	rotation += rand_range(-0.1, 0.1)
	velocity = transform.x * speed
	player = _player

func seek():
	var steer = Vector2.ZERO
	var screen = Vector2(OS.window_size.x/2, OS.window_size.y/2)
	if player:
		var desired = (player.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	if !player:
		var center = (screen - position).normalized() * speed
		steer = (center - velocity).normalized() * steer_force
	return steer

func _on_DetectRadius_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_DetectRadius_body_exited(body):
	player = null

func _on_enemy_body_entered(body):
	if body.is_in_group("player"):
		Global.health -= 1
		queue_free()
