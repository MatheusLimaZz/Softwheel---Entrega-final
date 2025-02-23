extends ColorRect

func _on_voltar_button_pressed():
	if ResourceLoader.exists("res://paginainicialcontrol.tscn"):
		get_tree().change_scene_to_file("res://paginainicialcontrol.tscn")
		print("Mudando para a cena: res://paginainicialcontrol.tscn")
	else:
		print("Erro: Cena res://paginainicialcontrol.tscn não encontrada!")
	
func _on_levantamento_button_pressed():
	if ResourceLoader.exists("res://Escolherquantidadejogadorescontrol.tscn"):
		get_tree().change_scene_to_file("res://Escolherquantidadejogadorescontrol.tscn")
		print("Mudando para a cena: res://Escolherquantidadejogadorescontrol.tscn")
	else:
		print("Erro: Cena res://Escolherquantidadejogadorescontrol.tscn não encontrada!")
		
func _on_desenvolvimento_button_pressed():
	if ResourceLoader.exists("res://Escolherquantidadejogadorescontrol.tscn"):
		get_tree().change_scene_to_file("res://Escolherquantidadejogadorescontrol.tscn")
		print("Mudando para a cena: res:/Escolherquantidadejogadorescontrol.tscn")
	else:
		print("Erro: Cena res://Escolherquantidadejogadorescontrol.tscn não encontrada!")
		
func _on_testeSoftware_button_pressed():
	if ResourceLoader.exists("res://Escolherquantidadejogadorescontrol.tscn"):
		get_tree().change_scene_to_file("res://Escolherquantidadejogadorescontrol.tscn")
		print("Mudando para a cena: res://Escolherquantidadejogadorescontrol.tscn")
	else:
		print("Erro: Cena res://Escolherquantidadejogadorescontrol.tscn não encontrada!")

# Função chamada quando o nó está pronto
func _ready():
	# Verifica se os botões existem antes de conectar
	if $VoltarButton and $levantamentoRodaButton and $testesSoftwareButton and $desenvolvimentoAgilButton:
		var voltar_button = $VoltarButton
		var levantamentoRodaButton = $levantamentoRodaButton
		var testesSoftwareButton = $testesSoftwareButton
		var desenvolvimentoAgilButton = $desenvolvimentoAgilButton
	
		# Conecta os sinais "pressed" dos botões às funções correspondentes
		voltar_button.connect("pressed", Callable(self, "_on_voltar_button_pressed"))
		levantamentoRodaButton.connect("pressed", Callable(self, "_on_levantamento_button_pressed"))
		testesSoftwareButton.connect("pressed", Callable(self, "_on_testeSoftware_button_pressed"))
		desenvolvimentoAgilButton.connect("pressed", Callable(self, "_on_desenvolvimento_button_pressed"))
	else:
		print("Erro: Botões Voltar button não encontrados na cena.")
