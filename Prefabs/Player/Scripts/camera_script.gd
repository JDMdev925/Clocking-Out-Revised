extends Marker3D

var cam : Camera3D

@onready var flashlight: SpotLight3D = $"../Flashlight"
var flashlight_rotation_smoothness = 15.0
var flashlight_position_smoothness = 15.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.warp_mouse(Vector2(position.x, position.y))
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	MainManager.connect("has_torch",Callable( self, "enable_torch"))
	cam = $Camera3D

func _unhandled_input(event: InputEvent) -> void:
	if (Input.mouse_mode == Input.MOUSE_MODE_CAPTURED) and (event is InputEventMouseMotion) and(!MainManager.MovementLocked):
		rotate_y(-event.relative.x * 0.01)
		cam.rotate_x(-event.relative.y * 0.01)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(60))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		update_flashlight(delta)
	#var mouse_x : float = cam.project_ray_normal()
	#var mouse_y : float = get_viewport().get_mouse_position().y
	
	#transform.basis = Basis(Vector3.RIGHT, mouse_x)
	#print(mouse_x)

func enable_torch() -> void:
	if MainManager.hasTorch:
		flashlight.visible = true
	
func update_flashlight(delta: float) -> void:
	flashlight.global_transform = Transform3D(
		flashlight.global_transform.basis.slerp(cam.global_transform.basis, delta * flashlight_rotation_smoothness),
		flashlight.global_transform.origin.slerp(cam.global_transform.origin, delta * flashlight_position_smoothness)
		)
	
