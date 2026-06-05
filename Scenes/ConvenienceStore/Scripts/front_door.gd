extends Interactable

var timer

func _ready() -> void:
	timer = Timer.new()
	MainManager.connect("update_dialogue",Callable( self, "updateDialogue"))
	timer.connect("timeout", Callable(self, "changeScene"))
	add_child(timer)
	timer.wait_time = 5
	timer.autostart = false
	
	
func object():
	if(MainManager.LightsComplete and MainManager.TillComplete and MainManager.ShelvesStacked and MainManager.hasKey):
		timer.start()

func updateDialogue():
	if(MainManager.BadLights):
		dialogue_key = "bad_door"
	else:
		if(MainManager.LightsComplete and MainManager.TillComplete and MainManager.ShelvesStacked):
			if(MainManager.hasKey):	
				dialogue_key = "good_end"
			else:
				dialogue_key = "no_key"
				
		else:
			dialogue_key = "good_tasks_unfinished"

func changeScene():
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.GOOD_END)
