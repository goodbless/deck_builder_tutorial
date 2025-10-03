class_name RunStats
extends Resource

signal gold_changed

const STARTING_GOLD := 70

@export var gold: int = STARTING_GOLD : set = set_gold

func set_gold(new_amount: int) -> void:
    gold = new_amount
    gold_changed.emit()