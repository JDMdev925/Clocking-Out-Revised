extends Node2D

func _on_button_pressed() -> void:
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	MainManager.endReached = true
