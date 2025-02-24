extends Control

#func _ready():
	#AudioPlayer.play_music_menu()

func _on_back_pressed():
	if(!MainManager.endReached):
		SceneSwitcher.switch_scene(SceneSwitcher.SceneType.MAIN_MENU)
		play_audio()
	else:
		get_tree().quit()  # Close the game
		OS.create_instance([])  # Restart the project

func play_audio():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.MENU_CLICK_3)
