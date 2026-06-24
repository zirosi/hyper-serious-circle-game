extends Control

var restart = false

func _on_restart_pressed() -> void:
	restart = true

func _on_end_pressed() -> void:
	get_tree().quit(0)
