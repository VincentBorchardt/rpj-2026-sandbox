extends Control

@export var messages: Array[Message]
var current_message_index = 0

@onready var left_image = $LeftSpeaker
@onready var right_image = $RightSpeaker

# TODO figure out how to do previous messages in this new paradigm

func start_cutscene(message_array):
	messages = message_array
	current_message_index = 0
	# more stuff
	show_message(current_message_index)
	self.visible = true
	
func show_message(message_index):
	var current_message = messages[message_index]
	if current_message.image_location == Message.Location.LEFT:
		left_image.texture = current_message.speaker.full_picture_left
	elif current_message.image_location == Message.Location.RIGHT:
		right_image.texture = current_message.speaker.full_picture_right
	# TODO show message text

# TODO capture "next message" input and both increment current_message_index and call show_message
