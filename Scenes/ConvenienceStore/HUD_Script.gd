extends Control
@export_group("HUD elements")
@export var key: Sprite2D
@export var boxFull: Sprite2D
@export var Title: RichTextLabel
@export var Obj1: CheckBox
@export var Obj2: CheckBox
@export var Obj3: CheckBox

@export_group("Pause Menu elements")
@export var pauseMenu : Control
@export var backButton : Button
@export var pauseTitle : Label
@export var generalMenu : Control
@export var settingsMenu : Control
@export var achievementMenu : Control
var paused : bool = false

@export_group("Achievement elements")
@export var vbox_one : VBoxContainer
@export var vbox_two : VBoxContainer
@export var achievements : PackedScene
var alternate : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MainManager.connect("shelves_stacked",Callable( self, "shelf"))
	MainManager.connect("till_complete",Callable( self, "till"))
	MainManager.connect("lights_off",Callable( self, "lights"))
	MainManager.connect("bad_ending_enabled",Callable( self, "bad"))
	MainManager.connect("has_key", Callable(self, "has_key"))
	pauseMenu.visible = false
	update_ui()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc"):
		TogglePauseMenu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_ui()
		
func update_ui():
	boxFull.visible = MainManager.HeldItem != null
	

func TogglePauseMenu() -> void:
	if (paused):
		pauseMenu.visible = false
		paused = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		MainManager.MovementLocked = false
	else:
		pauseMenu.visible = true
		generalMenu.visible = true
		pauseTitle.text = "GAME PAUSED"
		settingsMenu.visible = false
		achievementMenu.visible = false
		backButton.visible = false
		paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		MainManager.MovementLocked = true

func has_key():
	key.visible = true
	
func bad():
	print("hello")
	Obj1.visible = false
	Obj2.visible = false
	Obj3.visible = false
	Title.text = "FIND A WAY OUT"
	
func shelf():
	Obj1.button_pressed = true
func till():
	Obj2.button_pressed = true
func lights():
	Obj3.button_pressed = true
	print("hello")

func LoadAchievements() -> void:
	var config : ConfigFile = ConfigFile.new()
	
	
	var err = config.load("res://acheivements.cfg")
	if err != OK:
		return
	
	for i in config.get_sections():
		var new_ach = achievements.instantiate()
		if new_ach.get_child(2).get_child(0) is Label:
			new_ach.get_child(2).get_child(0).text = config.get_value(i, "Name")
		if new_ach.get_child(2).get_child(1) is Label:
			new_ach.get_child(2).get_child(1).text = config.get_value(i, "Tagline")
		if new_ach.get_child(3) is ColorRect:
			new_ach.get_child(3).visible = !config.get_value(i, "Awarded")
		
		if alternate:
			vbox_one.add_child(new_ach)
			alternate = false
		else:
			vbox_two.add_child(new_ach)
			alternate = true

func UnloadAchievements() -> void:
	if vbox_one.get_child_count() > 0:
		for child in vbox_one.get_children():
			child.queue_free()
	
	if vbox_two.get_child_count() > 0:
		for child in vbox_two.get_children():
			child.queue_free()


func _on_button_pressed() -> void:
	TogglePauseMenu()


func _on_button_2_pressed() -> void:
	generalMenu.visible = false
	achievementMenu.visible = true
	backButton.visible = true
	pauseTitle.text = "ACHIEVEMENTS"
	LoadAchievements()


func _on_button_3_pressed() -> void:
	generalMenu.visible = false
	settingsMenu.visible = true
	backButton.visible = true
	pauseTitle.text = "SETTINGS"


func _on_button_4_pressed() -> void:
	SceneSwitcher.switch_scene(0)


func _on_back_button_pressed() -> void:
	settingsMenu.visible = false
	if achievementMenu.visible:
		UnloadAchievements()
		achievementMenu.visible = false
	generalMenu.visible = true
	backButton.visible = false
	pauseTitle.text = "GAME PAUSED"
