extends Node2D

var enemy_scn = preload("res://scenes/enemy.tscn")

func _ready():
	$Timer.start()
	$end_timer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/main_menu.tscn")
	$CanvasLayer/score.text = str(Global.points)
	$CanvasLayer/health.text = "You've got " + str(Global.health) + " hits left!"
	if Global.points == 200:
		get_tree().change_scene("res://scenes/win.tscn")
	elif Global.health == 0:
		get_tree().change_scene("res://scenes/game_over.tscn")

func _on_Timer_timeout():
	var enemy = enemy_scn.instance()
	$EnemyPath/Spawner.offset = randi()
	add_child(enemy)
	enemy.position = $EnemyPath/Spawner.position


func _on_end_timer_timeout():
	get_tree().change_scene("res://scenes/game_over.tscn")
