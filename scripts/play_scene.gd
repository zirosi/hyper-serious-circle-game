extends Node2D

var score = 0

@onready var score_text = get_node("score")
@onready var circle = get_node("circle_area")
@onready var dot_container = get_node("dots")
@onready var end_screen = get_node("end_screen")
@onready var end_sound = get_node("end")
var dot_scene = preload("res://scenes/dot.tscn")

var most_recent_dot

func spawnDot() -> void:
	var dot_instance = dot_scene.instantiate()
	dot_container.add_child(dot_instance)
	most_recent_dot = dot_container.get_child(dot_container.get_child_count() - 1)

func start() -> void:
	if most_recent_dot != null:
		most_recent_dot.queue_free()
		circle.Rotation = 0
		circle.SPEED = 2.0
		score = 0
		score_text.text = str(score)
	
	circle.moving = true
	spawnDot()

func _ready() -> void:
	start()
	
var can_click_on_dot = false

func _on_circle_area_body_shape_entered(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	can_click_on_dot = true
	
func _on_circle_area_body_shape_exited(_body_rid: RID, _body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	can_click_on_dot = false

func lost() -> void:
	circle.moving = false
	end_screen.get_child(1).text = str("Score: ", score)
	end_screen.show()

func _process(_delta: float) -> void:
	if can_click_on_dot == true:
		if Input.is_action_just_pressed("click"):
			most_recent_dot.queue_free()
			spawnDot()
			score += 1
			circle.SPEED += 0.03
			most_recent_dot.get_node("pop_sfx").playing = true
			score_text.text = str(score)
			
	elif can_click_on_dot == false:
		if Input.is_action_just_pressed("click"):
			end_sound.playing = true
			lost()
	
	if end_screen.restart == true:
		end_screen.restart = false
		end_screen.hide()
		start()
