extends Node3D
@export var Display: Label
@export_file("*json") var dialogue_file: String
var dialogue_text = {}
var selected_text = []
var dialogue_index = 0
@export var typing_speed: float = 0.5  # Time between characters
@export var reading_speed: float = 3

var current_key;
var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainManager.connect("display_dialogue",Callable( self, "_on_display_dialogue"))
	dialogue_text = load_scene_text()
	Display.visible_characters = 0
	

# Function that runs when the signal is emitted
func _on_display_dialogue(dialogue_key):
	$Timer.stop()
	Display.visible_characters = 0
	current_index = 0
	Display.visible = true
	current_key = dialogue_key
	if dialogue_text.has(current_key):
		$Timer.wait_time = typing_speed
		selected_text = dialogue_text[current_key].duplicate()
		Display.text = selected_text[dialogue_index]
		
		$Timer.start()
		if current_index == 0:  
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.TALKING_SINGLE)
	else:
		print("Dialogue key not found:", dialogue_key)
	
func load_scene_text():
	if FileAccess.file_exists(dialogue_file):
		var file = FileAccess.open(dialogue_file, FileAccess.READ)
		var json_data = JSON.parse_string(file.get_as_text())

		if json_data is Dictionary:  # Ensure it's a valid Dictionary
			return json_data
		else:
			print("Error: Invalid JSON format in", dialogue_file)
			return {}  # Return an empty dictionary instead of null
		print("Error: Dialogue file not found:", dialogue_file)
		return {}  # Return an empty dictionary if file is missing


func _on_timer_timeout() -> void:
	if current_index < selected_text[dialogue_index].length():
		_show_next_character()
		$Timer.start()  # Start the timer for the next character to appear
	elif current_index == selected_text[dialogue_index].length():
		_wait_for_next_line()
	else:
		_finish_dialogue()

# Show the next character and play the sound effect.
func _show_next_character() -> void:
	Display.visible_characters += 1
	current_index += 1

# Wait before moving to the next line of dialogue.
func _wait_for_next_line() -> void:
	$Timer.wait_time = reading_speed
	current_index += 1
	$Timer.start()  # Start the timer for next line (after a pause)

# Finish the dialogue or move to the next one.
func _finish_dialogue() -> void:
	$Timer.stop()  # Stop the timer
	Display.visible = false
	current_index = 0
	Display.visible_characters = 0
	
	# Move to the next dialogue or loop back
	if selected_text.size() > dialogue_index + 1:
		dialogue_index += 1
		_on_display_dialogue(current_key)
	else:
		dialogue_index = 0
