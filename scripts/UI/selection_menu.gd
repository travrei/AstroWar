extends ColorRect

@onready var arrow: Label = $Arrow
@onready var container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	container.get_child(0).grab_focus()
	
func _process(_delta: float) -> void:
	var focus = get_viewport().gui_get_focus_owner()
	
	if focus is Button:
		var new_pos_y: float = focus.global_position.y + (focus.size.y /2) - 6
		var new_pos_x: float = focus.global_position.x - 20
		arrow.global_position = Vector2(new_pos_x, new_pos_y)
		
