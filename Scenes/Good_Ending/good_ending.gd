extends Node2D

func _ready() -> void:
	$Timer.start(0.5)


func _on_button_pressed() -> void:
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	MainManager.endReached = true


func _on_timer_timeout() -> void:
	AcheivementManager.UpdateAchievement("ACH_1")
