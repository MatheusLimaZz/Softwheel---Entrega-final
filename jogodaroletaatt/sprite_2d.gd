extends Sprite2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_voltar_button_pressed():
	if ResourceLoader.exists("res://paginainicialcontrol.tscn"):
		get_tree().change_scene_to_file("res://paginainicialcontrol.tscn")
		print("Mudando para a cena: res://paginainicialcontrol.tscn")
	else:
		print("Erro: Cena res://paginainicialcontrol.tscn não encontrada!")
func _ready():
	# Verifica se os botões existem antes de conectar
	if $Button:
		var voltar_button = $Button
		voltar_button.connect("pressed", Callable(self, "_on_voltar_button_pressed"))
	else:
		print("Erro: Botões Voltar button não encontrados na cena.")
