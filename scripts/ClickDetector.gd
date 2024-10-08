@tool
class_name MouseClickDetector
extends StaticBody3D
## Provides a filtered event for mouse clicks


## Emitted when a mouse button is pressed while the mouse pointer is inside any of this object's shapes.
signal mouse_clicked(button_index: int, event_position: Vector3)

const MOUSE_LAYER = 2


func _ready() -> void:
	if Engine.is_editor_hint():
		collision_layer = MOUSE_LAYER
		collision_mask = MOUSE_LAYER


func _input_event(_camera: Node, event: InputEvent, event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if Engine.is_editor_hint():
		return
	
	if event is not InputEventMouseButton or not event.is_pressed():
		return
	
	var mouse_button_event := event as InputEventMouseButton
	
	print(owner.name, " clicked. button index: ", mouse_button_event.button_index)
	
	mouse_clicked.emit(mouse_button_event.button_index, event_position)


## Disables all collision shapes
func disable() -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = true


## Enables all collision shapes
func enable() -> void:
	for child in get_children():
		if child is CollisionShape3D:
			child.disabled = false
