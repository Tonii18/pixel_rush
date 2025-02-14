extends ParallaxBackground

@export var base_speed: float = 200  # Velocidad base del desplazamiento
@export var acceleration: float = 5  # Aceleración de la velocidad

var current_speed: float  # Velocidad actual
var game_over: bool = false  # Variable para saber si el juego ha terminado

func _ready():
	current_speed = base_speed  # Inicializar la velocidad

func _process(delta):
	if game_over:
		return  # Si el juego ha terminado, no mover el fondo ni el suelo

	# Incrementar la velocidad progresivamente
	current_speed += acceleration * delta

	# Aplicar el movimiento a las capas
	for layer in get_children():
		if layer is ParallaxLayer:
			layer.motion_offset.x -= current_speed * layer.motion_scale.x * delta

func stop_movement():
	game_over = true  # Detener el movimiento del fondo y suelo
