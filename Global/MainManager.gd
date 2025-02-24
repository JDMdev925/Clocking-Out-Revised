extends Node

var rng = RandomNumberGenerator.new()

#Lock 
var MovementLocked = false

#3D Things
var HeldItem: Node3D
var ItemsPlaced : int
var Player: CharacterBody3D
var playerPos: Vector3

#Objectives Complete
var TillComplete = false
var ShelvesStacked = false
var LightsComplete = false

var hasKey = false
var hasTorch = false 

var BadLights = false
var LockComplete = false
var BoxComplete = false

var firstload = true

var endReached = false

signal display_dialogue(dialogue_key)
signal update_dialogue()

signal till_complete()
signal shelves_stacked()
signal lights_off()

signal has_key()
signal has_torch()

signal lock_complete()
signal box_complete()

signal bad_ending_enabled()

var beepTimer
var EerieTimer

func _ready() -> void:
	EerieTimer = rng.randi_range(1, 80)
	beepTimer = rng.randi_range(1, 80)

func _process(delta: float) -> void:
	if(SceneSwitcher.current_scene_type != SceneSwitcher.SceneType.MAIN_MENU && 
	SceneSwitcher.current_scene_type != SceneSwitcher.SceneType.CREDIT_MENU && 
	SceneSwitcher.current_scene_type != SceneSwitcher.SceneType.OPTIONS_MENU):
		StoreAudio(delta)
		
		if(!LightsComplete):
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LIGHT_LOOP)
	else:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.MENU_MUSIC)
		  

func increase_shelf_int():
	ItemsPlaced += 1
	if (ItemsPlaced >= 4):
		self.emit_signal("shelves_stacked")
		ShelvesStacked = true

func play_bg_audio():
	var randomInt = MainManager.rng.randi_range(1,3)
	match randomInt:
		1:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.EERIE_BG_1)
		2:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.EERIE_BG_2)
		3:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.EERIE_BG_3)
	
	
	
	
func StoreAudio(delta):
	EerieTimer -= delta
	if(EerieTimer <= 0):
		play_bg_audio()
		EerieTimer = rng.randi_range(1, 80)
	if(BadLights):
		beepTimer -= delta
		if(beepTimer <= 0):
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.BOMB_BEEP)
			beepTimer = rng.randi_range(1, 80)
