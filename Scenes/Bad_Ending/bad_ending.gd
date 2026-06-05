extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LAYERED_EXPLOSION)
	$Timer2.start(0.5)


func _on_timer_timeout() -> void:
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	MainManager.endReached = true


func _on_timer_2_timeout() -> void:
	AcheivementManager.UpdateAchievement("ACH_2")
