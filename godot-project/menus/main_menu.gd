extends Control

func _ready() -> void:
	$VersionLabel.text = "Version: " + ProjectSettings.get_setting("application/config/version")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")
