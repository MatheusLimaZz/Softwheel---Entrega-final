extends ColorRect

@onready var label_mensagem = $LabelMensagem  # Caminho do label para exibir o aviso

@onready var name_label = $Label     # Referência ao Label
@onready var name_input = $NameInput  # Pegando o LineEdit
@onready var confirm_button = $ConfirmButton 

#@onready var name_label = $Label     # Referência ao Label
@onready var name_input2 = $NameInput2  # Pegando o LineEdit
@onready var confirm_button2 = $ConfirmButton2

#@onready var name_label = $Label     # Referência ao Label
@onready var name_input3 = $NameInput3  # Pegando o LineEdit
@onready var confirm_button3 = $ConfirmButton3

func _on_voltar_button_pressed():
	if ResourceLoader.exists("res://Escolherquantidadejogadorescontrol.tscn"):
		get_tree().change_scene_to_file("res://Escolherquantidadejogadorescontrol.tscn")
		print("Mudando para a cena: res://Escolherquantidadejogadorescontrol.tscn")
	else:
		print("Erro: Cena res://Escolherquantidadejogadorescontrol.tscn não encontrada!")
		
func _on_play_button_pressed():
	if ResourceLoader.exists("res://spin_wheel.tscn"):
		if (Global.player_name == "") || (Global.player_name2 == "") || (Global.player_name3 == ""):
			label_mensagem.visible = true  # Mostra a mensagem de aviso
			label_mensagem.text = "Por favor, preencha o nome antes \nde jogar!" 
		else:
			get_tree().change_scene_to_file("res://spin_wheel.tscn")
			print("Mudando para a cena: res://spin_wheel.tscn") # Exibe aviso
	else:
		print("Erro: Cena res://spin_wheel.tscn não encontrada!")
		
		

func _on_button_confirmed_pressed():
	Global.player_name = name_input.text  # Armazena o nome digitado na variável global
	print("Nome salvo:", Global.player_name)

func _on_button_confirmed_pressed2():
	Global.player_name2 = name_input2.text  # Armazena o nome digitado na variável global
	print("Nome salvo:", Global.player_name2) 
	
func _on_button_confirmed_pressed3():
	Global.player_name3 = name_input3.text  # Armazena o nome digitado na variável global
	print("Nome salvo:", Global.player_name3) # Apenas para testar no console
	
func _ready():
	label_mensagem.visible = false  # Esconde a mensagem ao iniciar
	# Verifica se os botões existem antes de conectar
	if $Button_voltar:
		var Button_voltar = $Button_voltar
		var Button_play = $Button_play
	
		# Conecta os sinais "pressed" dos botões às funções correspondentes
		confirm_button.pressed.connect(_on_button_confirmed_pressed)
		confirm_button2.pressed.connect(_on_button_confirmed_pressed2)
		confirm_button3.pressed.connect(_on_button_confirmed_pressed3)  # Conectar o botão à função
		Button_voltar.connect("pressed", Callable(self, "_on_voltar_button_pressed"))
		Button_play.connect("pressed", Callable(self, "_on_play_button_pressed"))
	else:
		print("Erro: Botões Voltar button não encontrados na cena.")
		
	
		
