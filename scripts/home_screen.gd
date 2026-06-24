extends Control

@onready var sfx = get_node("end")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("click"):
		sfx.playing = true
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_file('res://scenes/play_scene.tscn')

func _on_button_pressed() -> void:
	sfx.playing = true
	await get_tree().create_timer(0.3).timeout
	get_tree().change_scene_to_file('res://scenes/play_scene.tscn')
