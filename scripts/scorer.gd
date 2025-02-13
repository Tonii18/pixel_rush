extends Node2D

@export var base_speed: float = 200  # Velocidad inicial del suelo
@export var acceleration: float = 5  # Aceleración gradual del suelo
@export var score_rate: float = 1.0  # Cuánto tarda en sumar 1 punto al inicio

var current_speed: float
var score: int = 0
var score_timer: float = 0.0  # Controla el tiempo para aumentar el puntaje

func _ready() -> void:
	current_speed = base_speed

func _process(delta: float) -> void:
	# Incrementar la velocidad progresivamente
	current_speed += acceleration * delta
	
	# Hacer que el puntaje aumente de forma controlada
	score_timer += delta

	# Reducir el tiempo entre aumentos de puntos conforme aumenta la velocidad
	var adjusted_rate = max(0.1, score_rate - (current_speed / 1000.0))

	if score_timer >= adjusted_rate:
		score += 1
		score_timer = 0.0  # Reiniciar el temporizador
	
	# Actualizar el marcador
	var score_label = get_node("Label")
	if score_label:
		score_label.text = "Score: " + str(score)
