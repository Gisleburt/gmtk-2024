extends StaticBody2D

@export_enum("Barren1", "Barren2", "Barren3", "Barren4", "Clouds", "Desert1", "Desert2", "ForrestClouds1", "ForrestClouds2", "ForrestNoClouds1", "ForrestNoClouds2", "GasGiant1", "GasGiant2", "GasGiant3", "GasGiant4", "Ice", "Lava1", "Lava2", "Lava3", "OceanClouds", "OceanNoClouds", "TerranClouds1", "TerranClouds2", "TerranNoClouds1", "TerranNoClouds2", "Tundra1", "Tundra2", ) var animation: String = "Barren1":
	set(an):
		$AnimatedSprite2D.animation = an
@export var edible_value: float = 1


func _ready() -> void:
	$AnimatedSprite2D.play()


func get_value() -> float:
	return edible_value
