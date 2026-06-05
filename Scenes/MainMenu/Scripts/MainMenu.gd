extends Control

#func _ready():
	#AudioPlayer.play_music_menu()

func _on_play_pressed():
	print("Play Pressed :)")
	MainManager.playerPos = Vector3(-5.76, 0.861, 21.71)
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.STORE)
	play_audio()

func _on_options_pressed():
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.OPTIONS_MENU)
	play_audio()

func _on_credits_pressed():
	SceneSwitcher.switch_scene(SceneSwitcher.SceneType.CREDIT_MENU)
	play_audio()

func _on_quit_pressed():
	get_tree().quit()

func play_audio():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.MENU_CLICK_3)
