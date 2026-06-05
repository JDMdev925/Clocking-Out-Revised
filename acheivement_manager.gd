extends Node

var config : ConfigFile = ConfigFile.new()
@onready var ach_widget : PackedScene = preload("res://Prefabs/Achievements/achievement.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = config.load("res://acheivements.cfg")
	
	if err != OK:
		CreateFile()

func UpdateAchievement(ach_id : String) -> void:
	if config.has_section(ach_id):
		
		if (config.get_value(ach_id, "Awarded") == false) && ((config.get_value(ach_id, "Conditions_Met")) < (config.get_value(ach_id, "Total_Conditions"))):
			
			config.set_value(ach_id, "Conditions_Met", config.get_value(ach_id, "Conditions_Met") + 1)
			
			if (config.get_value(ach_id, "Conditions_Met")) >= (config.get_value(ach_id, "Total_Conditions")):
				
				#Trigger award of achievement
				config.set_value(ach_id, "Awarded", true)
				print("Achievement: ", ach_id, " has been awarded!")
				AwardAchievement(ach_id)
			
			config.save("res://acheivements.cfg")
		
	

func AwardAchievement(ach_id : String) -> void:
	var new_ach = ach_widget.instantiate()
	
	if new_ach.get_child(2).get_child(0) is Label:
		new_ach.get_child(2).get_child(0).text = config.get_value(ach_id, "Name")
	if new_ach.get_child(2).get_child(1) is Label:
		new_ach.get_child(2).get_child(1).text = config.get_value(ach_id, "Tagline")
	if new_ach.get_child(3) is ColorRect:
		new_ach.get_child(3).visible = false
	
	get_tree().current_scene.add_child(new_ach)
	print("current_scene: ", get_tree().current_scene.name)
	new_ach.position.x = get_viewport().get_visible_rect().end.x - 650
	new_ach.position.y += 50
	new_ach.popout()
	print("POPOUT AWARD")


func CreateFile() -> void:
	# Achievement 1
	config.set_value("ACH_1", "Name", "Nothing went wrong")
	config.set_value("ACH_1", "Tagline", "Achieve the good ending")
	config.set_value("ACH_1", "Total_Conditions", 1)
	config.set_value("ACH_1", "Conditions_Met", 0)
	config.set_value("ACH_1", "Awarded", false)
	
	# Achievement 2
	config.set_value("ACH_2", "Name", "Curiosity killed the cat")
	config.set_value("ACH_2", "Tagline", "Achieve the true ending")
	config.set_value("ACH_2", "Total_Conditions", 1)
	config.set_value("ACH_2", "Conditions_Met", 0)
	config.set_value("ACH_2", "Awarded", false)
	
	# Achievement 3
	config.set_value("ACH_3", "Name", "Employee of the month")
	config.set_value("ACH_3", "Tagline", "Stack the shelves correctly")
	config.set_value("ACH_3", "Total_Conditions", 4)
	config.set_value("ACH_3", "Conditions_Met", 0)
	config.set_value("ACH_3", "Awarded", false)
	
	# Achievement 4
	config.set_value("ACH_4", "Name", "Lackluster job")
	config.set_value("ACH_4", "Tagline", "Stack the shelves completely wrong")
	config.set_value("ACH_4", "Total_Conditions", 4)
	config.set_value("ACH_4", "Conditions_Met", 0)
	config.set_value("ACH_4", "Awarded", false)
	
	config.save("res://acheivements.cfg")
