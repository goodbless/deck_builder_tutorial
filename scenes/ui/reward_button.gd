class_name RewardButton
extends Button

@export var reward_icon: Texture : set = _set_reward_icon
@export var reward_text: String : set = _set_reward_text

@onready var custom_icon: TextureRect = %CustomIcon
@onready var custom_text: Label = %CustomText

func _set_reward_icon(new_value: Texture) -> void:
	reward_icon = new_value

	if not is_node_ready():
		await ready

	custom_icon.texture = reward_icon

func _set_reward_text(new_value: String) -> void:
	reward_text = new_value

	if not is_node_ready():
		await ready

	custom_text.text = reward_text

func _on_pressed() -> void:
	queue_free()
