class_name CardTooltipPopup
extends Control

const CARD_MENU_UI_SCENE := preload("res://scenes/ui/card_menu_ui.tscn")

@onready var tooltip_card: CenterContainer = %TooltipCard
@onready var card_description: RichTextLabel = %CardDescription

func _ready() -> void:
	for card: CardMenuUI in tooltip_card.get_children():
		card.queue_free()

func show_tooltip(card: Card) -> void:
	var card_ui: CardMenuUI = CARD_MENU_UI_SCENE.instantiate()
	tooltip_card.add_child(card_ui)
	card_ui.card = card
	card_ui.tooltip_requested.connect(hide_tooltip.unbind(1))
	card_description.text = card.tooltip_text
	show()

func hide_tooltip() -> void:
	if not visible:
		return

	for card: CardMenuUI in tooltip_card.get_children():
		card.queue_free()

	hide()

func _on_gui_input(event:InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		hide_tooltip()
	
