extends Node2D

@export_subgroup("Planets")
@export var mercury_speed: float = 170
@export var venus_speed: float = 160
@export var earth_speed: float = 150
@export var mars_speed: float = 140
@export var jupiter_speed: float = 130
@export var saturn_speed: float = 120
@export var uranus_speed: float = 110
@export var neptune_speed: float = 100
@export var moon_speed: float = 50

@export_subgroup("Camera Zoom")
@export var zoom_speed: float = 1
@export var initial_zoom: float = 9
@onready var target_zoom: float = 2
var max_zoom: float = 1

@onready var zoom_current: float = $Node2D/StellarBlat/Camera2D.zoom.x

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var started: bool = false
var ended: bool = false

func _ready() -> void:
	$Planets/Mercury/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Venus/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	#$Planets/Earth/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Mars/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Jupiter/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Saturn/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Uranus/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Neptune/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	
	$Planets/Earth/PathFollow2D/Moon/PathFollow2D.progress_ratio += rng.randf_range(0, .25) - .125
	
	$Planets/Mars/PathFollow2D/Deimos/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Mars/PathFollow2D/Phobos/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Jupiter/PathFollow2D/Io/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Jupiter/PathFollow2D/Europa/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Jupiter/PathFollow2D/Ganymede/PathFollow2D.progress_ratio += rng.randf_range(0, 1)
	$Planets/Jupiter/PathFollow2D/Callisto/PathFollow2D.progress_ratio += rng.randf_range(0, 1)


func _process(delta: float) -> void:
	started = started or Input.is_action_pressed('right') or Input.is_action_pressed('left') or Input.is_action_pressed('down') or Input.is_action_pressed('up')
	
	if started:
		# Adjust the camera
		zoom_current = lerp(zoom_current, target_zoom, zoom_speed * delta)
		$Node2D/StellarBlat/Camera2D.zoom = Vector2(zoom_current, zoom_current)
		
		# progress planets
		$Planets/Mercury/PathFollow2D.progress += delta * mercury_speed
		$Planets/Venus/PathFollow2D.progress += delta * venus_speed
		$Planets/Earth/PathFollow2D.progress += delta * earth_speed
		$Planets/Mars/PathFollow2D.progress += delta * mars_speed
		$Planets/Jupiter/PathFollow2D.progress += delta * jupiter_speed
		$Planets/Saturn/PathFollow2D.progress += delta * saturn_speed
		$Planets/Uranus/PathFollow2D.progress += delta * uranus_speed
		$Planets/Neptune/PathFollow2D.progress += delta * neptune_speed
		
		$Planets/Earth/PathFollow2D/Moon/PathFollow2D.progress += delta * moon_speed
		$Planets/Mars/PathFollow2D/Deimos/PathFollow2D.progress += delta * moon_speed
		$Planets/Mars/PathFollow2D/Phobos/PathFollow2D.progress += delta * moon_speed
		$Planets/Jupiter/PathFollow2D/Io/PathFollow2D.progress += delta * moon_speed
		$Planets/Jupiter/PathFollow2D/Europa/PathFollow2D.progress += delta * moon_speed
		$Planets/Jupiter/PathFollow2D/Ganymede/PathFollow2D.progress += delta * moon_speed
		$Planets/Jupiter/PathFollow2D/Callisto/PathFollow2D.progress += delta * moon_speed


func _on_stellar_blat_win_condition_eaten() -> void:
	if !ended:
		ended = true
		get_tree().change_scene_to_file("res://menus/to_do.tscn")


#func _on_stellar_blat_scale_change(change: float, _scale: float) -> void:
	#target_zoom = maxf(max_zoom, target_zoom - change)


func _on_timer_timeout() -> void:
	$Node2D2/Tutorial.visible = false
