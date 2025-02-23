extends ColorRect


func _on_voltar_button_pressed():
	if ResourceLoader.exists("res://paginainicialcontrol.tscn"):
		get_tree().change_scene_to_file("res://paginainicialcontrol.tscn")
		print("Mudando para a cena: res://paginainicialcontrol.tscn")
	else:
		print("Erro: Cena res://paginainicialcontrol.tscn não encontrada!")

# Função chamada quando o nó está pronto
func _ready():
	# Verifica se os botões existem antes de conectar
	if $VoltarButton:
		var voltar_button = $VoltarButton
	
		# Conecta os sinais "pressed" dos botões às funções correspondentes
		voltar_button.connect("pressed", Callable(self, "_on_voltar_button_pressed"))
	else:
		print("Erro: Botões Voltar button não encontrados na cena.")
	
		
