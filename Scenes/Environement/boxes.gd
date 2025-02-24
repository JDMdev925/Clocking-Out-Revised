extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainManager.connect("box_complete", Callable(self, "destroy"))
	MainManager.connect("bad_ending_enabled", Callable(self, "changeEnding"))
	

func changeEnding():
	ID = 3
	dialogue_key = ""


func destroy():
	queue_free()
