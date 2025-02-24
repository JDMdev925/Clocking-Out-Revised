class_name Interactable
extends Node3D

@onready var SpriteRef : Sprite2D = $"../../../CanvasLayer/Control/Node2D/Sprite2D"
@onready var HUDcontrol : Control = $"../../../CanvasLayer/Control"

@export var parent : Sprite3D
@export var ID: int = -1
@export var dialogue_key:String = ""
@export var SceneType : SceneSwitcher.SceneType


func object() -> void:
	if(MainManager.HeldItem == null):
		MainManager.HeldItem = self
		visible = false
		position = Vector3(-5,-5,-5)
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PICKUP)
	

func area() -> void:
	var itempos : Marker3D
	for child in get_children():
		if(child.get("ID") != null):
			return
		if (child is Marker3D):
			itempos = child
	#PLACE OBJECT CODE HERE
	if(MainManager.HeldItem != null && itempos != null):
		reparent(MainManager.HeldItem)
		MainManager.HeldItem.visible = true
		MainManager.HeldItem.global_position = itempos.global_position
		MainManager.HeldItem.global_rotation = itempos.global_rotation
		MainManager.HeldItem = null
		MainManager.increase_shelf_int()
		
		play_audio()

func read() -> void:
	SpriteRef.texture = get_parent().texture
	HUDcontrol.mouse_filter = Control.MOUSE_FILTER_STOP
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PICKUP)
	MainManager.MovementLocked = true
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		drop() 
	if event.is_action_pressed("Return"):
		release()

func drop() -> void: 
	if(MainManager.HeldItem != null):
		play_audio()
		MainManager.HeldItem.visible = true
		MainManager.HeldItem.global_position = MainManager.playerPos
		MainManager.HeldItem = null
	
func release() -> void:
	if SpriteRef != null:
		SpriteRef.texture = null
		HUDcontrol.mouse_filter = Control.MOUSE_FILTER_IGNORE
		MainManager.MovementLocked = false

func change_scene():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SceneSwitcher.switch_scene(SceneType)
	
func play_audio():
	var randomInt = MainManager.rng.randi_range(1,4)
	match randomInt:
		1:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLACING_ITEM_CAN_1)
		2:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLACING_ITEM_CAN_2)
		3:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLACING_ITEM_BOX_1)
		4:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.PLACING_ITEM_BOX_2)
