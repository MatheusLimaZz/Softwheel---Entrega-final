extends ColorRect

var rotation_speed = 0
var spin_time_range = Vector2(2, 4)  # Intervalo aleatório para o tempo de rotação
var spin_time = 0.0        # Tempo total de rotação aleatório (em segundos)
var elapsed_time = 0.0     # Tempo já passado
var deceleration = 0.0     # Desaceleração aleatória
var is_spinning = false
var perguntas = [
	"O que é levantamento de requisitos?",
	"Quais são as principais fontes de requisitos em um projeto?",
	"O que são requisitos funcionais e não funScionais?",
	"Por que é importante envolver os stakeholders no levantamento de requisitos?",
	"Como você lida com requisitos conflitantes entre diferentes stakeholders?",
	"Quais são algumas técnicas comuns para coletar requisitos"
]

func _ready():
	randomize()
	if $Sprite2D.texture:
		$Sprite2D.centered = true  # Centraliza o pivô no centro da textura
		# Ajusta a posição para compensar o deslocamento causado pelo pivô centralizado
		$Sprite2D.position += Vector2(
			$Sprite2D.texture.get_width() / 2,  # Compensa a largura
			$Sprite2D.texture.get_height() / 2 # Compensa a altura
		)
	else:
		print("A textura não está configurada no Sprite2D!")

func _process(delta):
	if is_spinning:
		elapsed_time += delta
		# Aplica a desaceleração aleatória
		rotation_speed = max(0, rotation_speed - deceleration * delta)

		# Aplica a rotação
		$Sprite2D.rotation_degrees += rotation_speed * delta

		# Verifica se o tempo de rotação acabou
		if elapsed_time >= spin_time:
			is_spinning = false
			rotation_speed = 0
			escolher_pergunta()

func escolher_pergunta():
	var angulo = int($Sprite2D.rotation_degrees) % 360
	if angulo < 0:
		angulo += 360
	var setor = int(angulo / (360 / 6))
	var pergunta = perguntas[setor]
	exibir(pergunta)

func exibir(pergunta):
	print("Pergunta: ", pergunta)

func start_spin():
	if not is_spinning:
		is_spinning = true
		# Randomiza o tempo de rotação dentro do intervalo definido
		spin_time = randf_range(spin_time_range.x, spin_time_range.y)
		# Randomiza a desaceleração dentro de um intervalo (ajuste conforme necessário)
		deceleration = randf_range(300, 500)
		elapsed_time = 0.0  # Reinicia o tempo
		print("Tempo de rotação: ", spin_time)
		print("Desaceleração: ", deceleration)
		# Garante que a roleta comece com a velocidade máxima
		rotation_speed = 1000

# Chamado quando o botão é pressionado
func _on_button_ativar_roleta_pressed() -> void:
	start_spin()
