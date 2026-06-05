extends Interactable

var waitTimer
var beenHit = false
var start = false

func _process(delta: float) -> void:
	if(start):
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.BOMB_BEEP)

func read() -> void:
	start = true
	waitTimer = Timer.new()
	add_child(waitTimer)
	waitTimer.wait_time = 5
	waitTimer.start()
	waitTimer.connect("timeout", Callable(self, "_on_timer_timeout"))
	MainManager.MovementLocked = true

func _on_timer_timeout() -> void:
	if(beenHit):
		start = false
		waitTimer.stop()
		SceneSwitcher.switch_scene(SceneSwitcher.SceneType.BAD_END)
	else:
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.SHOVEL_HIT)
		beenHit = true
		waitTimer.wait_time = 4
		waitTimer.start()
	
	
