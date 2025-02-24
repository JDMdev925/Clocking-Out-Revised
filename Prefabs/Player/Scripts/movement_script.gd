extends CharacterBody3D


const SPEED = 400
var camera : Marker3D
@onready var animator : AnimationPlayer = $Pivot/Camera3D/Bobbing

func _ready() -> void:
	MainManager.MovementLocked = false
	camera = $Pivot
	
	if(MainManager.playerPos != null and !MainManager.firstload):
		global_position = MainManager.playerPos
	else:
		MainManager.firstload = false
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

# movement & rotation
	var h_axis : float = Input.get_axis("c_left", "c_right")
	var v_axis : float = Input.get_axis("c_up","c_down")
	
	var direction : Vector3 = (camera.basis * Vector3(h_axis, 0, v_axis)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED * delta
		velocity.z = direction.z * SPEED * delta
	else:
		velocity.x = move_toward(direction.x, 0, SPEED)
		velocity.z = move_toward(direction.z, 0, SPEED)
		

	if (!MainManager.MovementLocked):
		if direction != Vector3() and !animator.is_playing():
			animator.play("head_bob")
			MainManager.playerPos = global_position 
			call_deferred("play_audio")
		move_and_slide()
	

		
	
func play_audio():
	var randomInt = MainManager.rng.randi_range(1,3)
	match randomInt:
		1:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.FOOTSTEP_1)
		2:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.FOOTSTEP_2)
		3:
			AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.FOOTSTEP_3)
