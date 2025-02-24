extends Node2D
@export var Lock:Sprite2D
@export var Combination:Array[int]
var UserInput: Array[int]
var isMouse
var mouse_left_down = false
var puzzleStarted = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Lock.rotation_degrees = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if((mouse_left_down) and puzzleStarted):
		turnLock(delta)
	elif(puzzleStarted):
		checkPos()
	if(UserInput.size() == 4):
		confirm(delta)


func turnLock(delta) ->void:
	play_audio()
	var rotation_speed = 1 * delta  # Adjust speed factor
	var target_rotation = Lock.rotation_degrees
	target_rotation += 90

	# Smooth transition using lerp
	Lock.rotation_degrees = lerp(Lock.rotation_degrees, target_rotation, rotation_speed)
	

func checkPos() ->void:
	var normalized_rotation = fmod(Lock.rotation_degrees, 360)
	
	if(normalized_rotation >= 355 or normalized_rotation <= 15):
		UserInput.append(1)	
	
	if(normalized_rotation >= 80 and normalized_rotation <= 100):
		UserInput.append(2)	
	
	if(normalized_rotation >= 170 and normalized_rotation <= 190):
		UserInput.append(3)	
		
	if(normalized_rotation >= 260 and normalized_rotation <= 280):
		UserInput.append(4)	
		
	puzzleStarted = false

func confirm(delta) -> void:
	if (Combination == UserInput):
		MainManager.LockComplete = true

		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.DIR_LOCK_RIGHT)
		SceneSwitcher.switch_scene(SceneSwitcher.SceneType.STORE)
	else:
		UserInput.clear()
		puzzleStarted = false
		AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.DIR_LOCK_WRONG)
		Lock.rotation_degrees = 360

func _on_area_2d_mouse_entered() -> void:
	isMouse = true;

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and isMouse and event.pressed:
			mouse_left_down = true
			puzzleStarted = true
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			mouse_left_down = false
		

func _on_area_2d_mouse_exited() -> void:
	if(!mouse_left_down):
		isMouse = false;


func _on_button_pressed() -> void:
	UserInput.clear()
	puzzleStarted = false
	Lock.rotation_degrees = 0
	
func play_audio():
	var randomInt = MainManager.rng.randi_range(1,2)
	var play = MainManager.rng.randi_range(1,10)
	if(play%3 == 0):
		match randomInt:
			1:
				AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LOCK_CLICK_1)
			2:
				AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LOCK_CLICK_2)
