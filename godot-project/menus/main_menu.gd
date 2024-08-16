extends Control


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")
