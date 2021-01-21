extends Control

func _ready():
	Global.health = 5
	pass


func _on_startbutton_pressed():
	get_tree().change_scene("res://scenes/level.tscn")
