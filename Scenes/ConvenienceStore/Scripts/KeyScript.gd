extends Interactable

func _ready() -> void:
	MainManager.connect("bad_ending_enabled",Callable(self, "disappear"))
	MainManager.connect("update_dialogue",Callable( self, "updateDialogue"))
	
func object() -> void:
	print(MainManager.LightsComplete)
	print(MainManager.TillComplete)
	print(MainManager.ShelvesStacked)
	if(MainManager.LightsComplete and MainManager.TillComplete and MainManager.ShelvesStacked):
		visible = false
		position = Vector3(-5,-5,-5)
		MainManager.hasKey = true

func updateDialogue():
	if(MainManager.hasKey):
		dialogue_key = "good_tasks_finished"
	else:
		dialogue_key = "good_tasks_unfinished"
		
func disappear():
	queue_free()
