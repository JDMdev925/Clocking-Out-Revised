extends Interactable

func _ready() -> void:
	MainManager.connect("bad_ending_enabled",Callable(self, "appear"))
	
func object() -> void:
	if(MainManager.BadLights):
		get_parent().visible = false
		position = Vector3(-5,-5,-5)
		MainManager.hasTorch = true
		MainManager.emit_signal("has_torch")
		
func appear():
	get_parent().visible = true
	
