extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LAYERED_EXPLOSION)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	MainManager.endReached = true
