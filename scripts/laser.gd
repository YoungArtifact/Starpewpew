extends Area2D

var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_laser_body_entered(body):
	if body.is_in_group("player"):
		return
	queue_free()

func _on_laser_area_entered(area):
	if area.is_in_group("enemies"):
		area.queue_free()
		Global.points += 10
