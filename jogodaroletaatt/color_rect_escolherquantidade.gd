extends ColorRect


func _on_voltar_button_pressed():
	if ResourceLoader.exists("res://escolhertemacontrol.tscn"):
		get_tree().change_scene_to_file("res://escolhertemacontrol.tscn")
		print("Mudando para a cena: res://escolhertemacontrol.tscn")
	else:
		print("Erro: Cena res://escolhertemacontrol.tscn não encontrada!")
	
func _on_1jogador_button_pressed():
	if ResourceLoader.exists("res://jogador1.tscn"):
		get_tree().change_scene_to_file("res://jogador1.tscn")
		print("Mudando para a cena: res://jogador1.tscn")
	else:
		print("Erro: Cena res://jogador1.tscn não encontrada!")
		
func _on_2jogador_button_pressed():
	if ResourceLoader.exists("res://jogador2.tscn"):
		get_tree().change_scene_to_file("res://jogador2.tscn")
		print("Mudando para a cena: res://jogador2.tscn")
	else:
		print("Erro: Cena res://jogador2.tscn não encontrada!")
		
func _on_3jogador_button_pressed():
	if ResourceLoader.exists("res://jogador3.tscn"):
		get_tree().change_scene_to_file("res://jogador3.tscn")
		print("Mudando para a cena: res://jogador3.tscn")
	else:
		print("Erro: Cena res://jogador3.tscn não encontrada!")
		
func _on_testeSoftware_button_pressed():
	if ResourceLoader.exists("res://roleta.tscn"):
		get_tree().change_scene_to_file("res://roleta.tscn")
		print("Mudando para a cena: res://roleta.tscn")
	else:
		print("Erro: Cena res://roleta.tscn não encontrada!")

# Função chamada quando o nó está pronto
func _ready():
	# Verifica se os botões existem antes de conectar
	if $VoltarButton and $Button1player and $Button2players and $Button3players:
		var voltar_button = $VoltarButton
		var singleplayer_button = $Button1player
		var twoplayers_button = $Button2players 
		var threeplayers_button = $Button3players
	
		# Conecta os sinais "pressed" dos botões às funções correspondentes
		voltar_button.connect("pressed", Callable(self, "_on_voltar_button_pressed"))
		singleplayer_button.connect("pressed", Callable(self, "_on_1jogador_button_pressed"))
		twoplayers_button.connect("pressed", Callable(self, "_on_2jogador_button_pressed"))
		threeplayers_button.connect("pressed", Callable(self, "_on_3jogador_button_pressed"))
	else:
		print("Erro: Botões Voltar button não encontrados na cena.")
