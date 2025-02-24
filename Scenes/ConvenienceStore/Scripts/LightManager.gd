extends Node

func _ready() -> void:
	MainManager.connect("lights_off",Callable(self, "updateLights"))

func updateLights():
	var StoreLights = get_tree().get_nodes_in_group("StoreLights")
	for lights in StoreLights:
		if lights is OmniLight3D:  
			lights.light_energy = 0
