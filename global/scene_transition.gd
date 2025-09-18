extends Control
@onready var mask: ColorRect = $Mask
@onready var texture: TextureRect = $TextureRect

@export var fade_out_duration: float = 1.0
@export var fade_in_duration: float = 1.0

@export var shrink_dration: float = 1.0

func _ready() -> void:
	mask.visible = false
	mask.self_modulate = Color(1, 1, 1, 0)
	texture.visible = false
	texture.self_modulate = Color(1, 1, 1, 0)
	texture.scale = Vector2(1, 1)

# 黑幕转场
func transition_fade_out_in(packed_scene: PackedScene) -> void:
	mask.visible = true
	mask.self_modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(mask, "self_modulate", Color(1, 1, 1, 1), fade_out_duration)
	tween.tween_callback(get_tree().change_scene_to_packed.bind(packed_scene))
	tween.tween_property(mask, "self_modulate", Color(1, 1, 1, 0), fade_in_duration)
	await  tween.finished
	mask.visible = false

# 淡出转场
func transition_fade_out(packed_scene: PackedScene) -> void:
	var image = get_viewport().get_texture().get_image()
	texture.texture = ImageTexture.create_from_image(image)
	texture.visible = true
	texture.self_modulate = Color(1, 1, 1, 1)
	
	get_tree().change_scene_to_packed(packed_scene)
	
	var tween = create_tween()
	tween.tween_property(texture, "self_modulate", Color(1, 1, 1, 0), fade_out_duration)
	await tween.finished
	texture.texture = null
	texture.visible = false

# 缩小转场
func transition_shrink(packed_scene: PackedScene) -> void:
	var image = get_viewport().get_texture().get_image()
	texture.texture = ImageTexture.create_from_image(image)
	texture.visible = true
	texture.scale = Vector2(1, 1)
	texture.self_modulate = Color(1, 1, 1, 1)
	
	get_tree().change_scene_to_packed(packed_scene)
	
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(texture, "scale", Vector2(0, 0), shrink_dration)
	await tween.finished
	texture.texture = null
	texture.visible = false
