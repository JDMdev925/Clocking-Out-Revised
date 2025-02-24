extends Node2D
@export var Light1:Sprite2D
@export var Light2:Sprite2D
@export var Light3:Sprite2D
@export var Light4:Sprite2D
@export var Light5:Sprite2D
@export var Button5:Button
var A = false
var B = false
var C = false
var D = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changeColours()
	checkCorrect()


func _on_button_1_pressed() -> void:
	A = not A
	B = not B
	play_audio()

func _on_button_2_pressed() -> void:
	A = not A
	C = not C
	play_audio()
	

func _on_button_3_pressed() -> void:
	B = not B
	C = not C
	play_audio()
	
func _on_button_4_pressed() -> void:
	C = not C
	D = not D
	play_audio()

func changeColours() -> void:
	if(A):
		Light1.modulate = Color(Color(0.409, 0.735, 0.225))
	else:
		Light1.modulate = Color(0.813, 0.322, 0)
	if(B):
		Light2.modulate = Color(Color(0.409, 0.735, 0.225))
	else:
		Light2.modulate = Color(0.813, 0.322, 0)
	if(C):
		Light3.modulate = Color(Color(0.409, 0.735, 0.225))
	else:
		Light3.modulate = Color(0.813, 0.322, 0)
	if(D):
		Light4.modulate = Color(Color(0.409, 0.735, 0.225))
	else:
		Light4.modulate = Color(0.813, 0.322, 0)

func checkCorrect() -> void:
	if(A and B and C and D) and !MainManager.LightsComplete and !MainManager.hasKey:
		Light5.modulate = Color(0.681, 0.537, 0.873)
		MainManager.LightsComplete = true
		for button in get_children():
			if button is Button:
				button.disabled = true
		Button5.disabled = false
	elif(MainManager.LightsComplete):
		Light1.modulate = Color(Color(0.409, 0.735, 0.225))
		Light2.modulate = Color(Color(0.409, 0.735, 0.225))
		Light3.modulate = Color(Color(0.409, 0.735, 0.225))
		Light4.modulate = Color(Color(0.409, 0.735, 0.225))
		Light5.modulate = Color(1, 0.02, 0.554)
		MainManager.LightsComplete = true
		Button5.disabled = false
		


func _on_bad_button_pressed() -> void:
	play_audio()
	MainManager.BadLights = true

func play_audio():
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.LOCK_CLICK_2)

		
