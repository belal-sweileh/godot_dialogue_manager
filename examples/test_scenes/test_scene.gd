extends Node2D


@export var Balloon: PackedScene
@export var SmallBalloon: PackedScene
@export var title: String = "start"
@export var dialogue_resource: Resource


func _ready():
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	
	await get_tree().create_timer(0.4).timeout
	show_dialogue(title)


func show_dialogue(key: String) -> void:
	var is_small_window: bool = ProjectSettings.get_setting("display/window/size/viewport_width") < 400
	var balloon: Node = (SmallBalloon if is_small_window else Balloon).instantiate()
	add_child(balloon)
	balloon.start(dialogue_resource, key)


### Signals


func _on_dialogue_finished():
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()
