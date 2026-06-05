extends Node2D

func _ready() -> void:
	AcheivementManager.UpdateAchievement("ACH_1")


func _on_button_pressed() -> void:
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	MainManager.endReached = true
