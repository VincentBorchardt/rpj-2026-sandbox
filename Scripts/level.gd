extends Node2D

@onready var cutscene = $CutsceneOverlay

@export var messages: Array[Message]

# TODO this needs a "cutscene in progress" variable somewhere--probably a global?
func _on_button_pressed() -> void:
	cutscene.start_cutscene(messages)
