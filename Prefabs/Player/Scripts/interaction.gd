extends Area3D

signal item_highlight(toggle:bool)

var in_view : Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event.is_action_pressed("left_click"):
		if in_view != null:
			match in_view.get("ID"):
				0:
					
					in_view.object()
				1:
					in_view.area()
				2:
					in_view.read()
				3:
					in_view.change_scene()
		  
	   #DialogueAreaHandle
			MainManager.emit_signal("update_dialogue")
			if(in_view.get("dialogue_key") != null):
				MainManager.emit_signal("display_dialogue", in_view.get("dialogue_key"))

	

func _on_body_entered(body: Node3D) -> void:
	if body.get("ID") != null or body.get("dialogue_key") != null:
		in_view = body
		item_highlight.emit(true)


func _on_body_exited(body: Node3D) -> void:
	if body.get("ID") != null or body.get("dialogue_key") != null:
		in_view = null
		item_highlight.emit(false)
