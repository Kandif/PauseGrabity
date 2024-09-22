extends Control

@export var id:int = 1

@export var star2:int = 2
@export var star3:int = 3

@export var id_map = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Cosek.licznik = 0
	$CanvasLayer.id = id

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
