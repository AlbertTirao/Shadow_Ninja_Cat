extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	print("Back Pressed")


func _on_scene_level_part_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_Selection.tscn")
