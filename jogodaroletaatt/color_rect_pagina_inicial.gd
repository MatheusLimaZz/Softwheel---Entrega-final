extends ColorRect


# Função chamada quando o botão de "Jogar" é pressionado
func _on_jogar_button_pressed():
	if ResourceLoader.exists("res://escolhertemacontrol.tscn"):
		get_tree().change_scene_to_file("res://escolhertemacontrol.tscn")
		print("Mudando para a cena: escolhertemacontrol.tscn")
	else:
		print("Erro: Cena escolhertemacontrol.tscn não encontrada!")

# Função chamada quando o botão de "Regras" é pressionado
func _on_regras_button_pressed():
	if ResourceLoader.exists("res://regrascontrol.tscn"):
		get_tree().change_scene_to_file("res://regrascontrol.tscn")
		print("Mudando para a cena: regrascontrol.tscn")
	else:
		print("Erro: Cena regrascontrol.tscn não encontrada!")
		# Supondo que você esteja no script da página inicial

func _on_exit_button_pressed():
	# Fecha o jogo
	get_tree().quit()


# Função chamada quando o nó está pronto
func _ready():
	# Verifica se os botões existem antes de conectar
	if $JogarButton and $RegrasButton and $sairButton:
		var jogar_button = $JogarButton
		var regras_button = $RegrasButton
		var sair_button = $sairButton

		# Conecta os sinais "pressed" dos botões às funções correspondentes
		jogar_button.connect("pressed", Callable(self, "_on_jogar_button_pressed"))
		regras_button.connect("pressed", Callable(self, "_on_regras_button_pressed"))
		 # Conecta o botão "sair" à função _on_exit_button_pressed
		sair_button.connect("pressed", Callable(self, "_on_exit_button_pressed"))
	else:
		print("Erro: Botões JogarButton ou RegrasButton não encontrados na cena.")
