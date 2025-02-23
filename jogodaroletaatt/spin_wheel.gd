extends Control

@export var is_spin: bool = false
@export var speed: int = 10
@export var power: int = 2
@export var reward_position = 0
signal sig_reward

@onready var game_over_label = $ColorRect/GameOverLabel  # Label que exibe "Game Over"
@onready var question_panel = $ColorRect/QuestionPanel
@onready var question_label = $ColorRect/QuestionPanel/QuestionLabel
@onready var skip_button = $ColorRect/QuestionPanel/SkipButton
@onready var option_buttons = [
	$ColorRect/QuestionPanel/QuestionLabel/Option1, 
	$ColorRect/QuestionPanel/QuestionLabel/Option2, 
	$ColorRect/QuestionPanel/QuestionLabel/Option3, 
	$ColorRect/QuestionPanel/QuestionLabel/Option4
]

@onready var score_label = $ColorRect/ScoreLabel
@onready var feedback_popup = $ColorRect/FeedbackPopup
  

var current_difficulty = ""  # Será "facil", "medio" ou "dificil"

# Contador de pulos (skip)
var skip_count = 0
const MAX_SKIPS = 5

var questions_generated = {
	"facil": 0,
	"medio": 0,
	"dificil": 0
}

# Banco de perguntas dividido em três dificuldades
var questions = {
	"facil": [
		{
			"pergunta": "O que é Scrum?",
			"alternativas": ["Uma linguagem de programação", "Um framework ágil", "Um banco de dados", "Um método de teste"],
			"correta": 1
		},
		{
			"pergunta": "O que significa a sigla XP em metodologias ágeis?",
			"alternativas": ["Extreme Programming", "Xtreme Planning", "Extended Process", "eXtra Performance"],
			"correta": 0
		},
		{
			"pergunta": "Qual é o papel do Product Owner no Scrum?",
			"alternativas": ["Desenvolver o código", "Gerenciar o time de desenvolvimento", "Definir e priorizar os requisitos do produto", "Realizar testes automatizados"],
			"correta": 2
		},
		{
			"pergunta": "O que é um Sprint no Scrum?",
			"alternativas": ["Uma reunião diária", "Um período de tempo fixo para desenvolvimento", "Uma fase de testes", "Um conjunto de regras para desenvolvimento"],
			"correta": 1
		},
		{
			"pergunta": "Qual destes eventos faz parte do Scrum?",
			"alternativas": ["Pair Programming", "Sprint Review", "Testes unitários", "Deploy Contínuo"],
			"correta": 1
		},
		{
			"pergunta": "Qual artefato do Scrum contém os requisitos priorizados?",
			"alternativas": ["Sprint Backlog", "Product Backlog", "Definition of Done", "Kanban Board"],
			"correta": 1
		},
		{
			"pergunta": "Quem é responsável por garantir que o time siga as práticas do Scrum?",
			"alternativas": ["Scrum Master", "Product Owner", "Stakeholder", "Desenvolvedor"],
			"correta": 0
		},
		{
			"pergunta": "O que significa a sigla TDD?",
			"alternativas": ["Test-Driven Development", "Technical Development Design", "Task-Defined Deployment", "Time-Defined Development"],
			"correta": 0
		},
		{
			"pergunta": "Qual metodologia ágil utiliza o conceito de Kanban?",
			"alternativas": ["Scrum", "XP", "Lean", "FDD"],
			"correta": 2
		},
		{
			"pergunta": "O que ocorre na Daily Scrum?",
			"alternativas": ["Definição dos requisitos", "Execução dos testes", "Planejamento do projeto", "Atualização diária do progresso do time"],
			"correta": 3
		},
		{
			"pergunta": "O que é Kanban?",
			"alternativas": ["Um método de gestão visual", "Uma linguagem de programação", "Um sistema operacional", "Um framework ágil"],
			"correta": 0
		},
		{
			"pergunta": "Qual desses papéis não existe no Scrum?",
			"alternativas": ["Scrum Master", "Product Owner", "Desenvolvedor", "Gerente de Projeto"],
			"correta": 3
		},
		{
			"pergunta": "O que é um backlog no contexto do Scrum?",
			"alternativas": ["Um conjunto de histórias de usuário pendentes", "Uma lista de tarefas concluídas", "Um sistema de versionamento", "Um documento de requisitos de sistema"],
			"correta": 0
		},
		{
			"pergunta": "O que é um Product Backlog?",
			"alternativas": ["Uma lista priorizada de requisitos do produto", "Uma coleção de histórias de usuário não priorizadas", "Um documento de visão do produto", "Uma agenda de reuniões"],
			"correta": 0
		},
		{
			"pergunta": "Qual é o objetivo principal do Scrum Master?",
			"alternativas": ["Garantir que a equipe siga os processos do Scrum", "Definir os requisitos do produto", "Estabelecer a estratégia de mercado", "Gerenciar a comunicação com clientes"],
			"correta": 0
		}
	],
	"medio": [
		{
			"pergunta": "Qual o tempo recomendado para uma Sprint no Scrum?",
			"alternativas": ["1 mês", "6 semanas", "Até 4 semanas", "3 meses"],
			"correta": 2
		},
		{
			"pergunta": "O que significa o termo 'Definition of Done' no Scrum?",
			"alternativas": ["Os critérios de aceitação de uma tarefa", "A definição do backlog", "A reunião de encerramento da Sprint", "Uma lista de tarefas pendentes"],
			"correta": 0
		},
		{
			"pergunta": "Quem é responsável por criar o Sprint Backlog?",
			"alternativas": ["Scrum Master", "Product Owner", "Time de Desenvolvimento", "Stakeholders"],
			"correta": 2
		},
		{
			"pergunta": "Qual destas práticas faz parte do XP (Extreme Programming)?",
			"alternativas": ["Testes automatizados", "Waterfall", "Reuniões diárias", "Histórias de usuário"],
			"correta": 0
		},
		{
			"pergunta": "O que acontece na Sprint Review?",
			"alternativas": ["O time define o próximo Sprint", "Os stakeholders avaliam o que foi desenvolvido", "Os desenvolvedores revisam o código", "O Product Owner adiciona novas histórias ao backlog"],
			"correta": 1
		},
		{
			"pergunta": "Qual princípio do Manifesto Ágil prioriza 'pessoas e interações'?",
			"alternativas": ["Indivíduos e interações mais que processos e ferramentas", "Software funcionando mais que documentação", "Colaboração com o cliente mais que negociação de contratos", "Resposta a mudanças mais que seguir um plano"],
			"correta": 0
		},
		{
			"pergunta": "No Scrum, quando um Sprint pode ser cancelado?",
			"alternativas": ["Quando o time decide", "Quando o Scrum Master determina", "Quando os stakeholders solicitam", "Quando o Product Owner percebe que o objetivo não é mais válido"],
			"correta": 3
		},
		{
			"pergunta": "O que é um Burndown Chart?",
			"alternativas": ["Uma lista de tarefas pendentes", "Um gráfico que mostra o progresso do Sprint", "Um documento de requisitos", "Uma técnica de refatoração"],
			"correta": 1
		},
		{
			"pergunta": "Qual destes NÃO é um princípio ágil?",
			"alternativas": ["Entrega contínua de software", "Planejamento fixo e detalhado", "Colaboração com o cliente", "Adaptação a mudanças"],
			"correta": 1
		},
		{
			"pergunta": "O que é um Epic em metodologias ágeis?",
			"alternativas": ["Uma grande história de usuário", "Um framework ágil", "Uma ferramenta de gerenciamento de projetos", "Uma reunião de retrospectiva"],
			"correta": 0
		},
		{
			"pergunta": "Qual é a função do Sprint Planning no Scrum?",
			"alternativas": ["Revisar o trabalho anterior", "Definir as tarefas da Sprint", "Discutir impedimentos", "Avaliar a performance individual"],
			"correta": 1
		},
		{
			"pergunta": "Qual o objetivo da Sprint Retrospective?",
			"alternativas": ["Planejar o próximo Sprint", "Revisar o backlog", "Melhorar processos e práticas do time", "Determinar a duração do Sprint"],
			"correta": 2
		},
		{
			"pergunta": "Qual técnica é frequentemente usada para estimar tarefas no Scrum?",
			"alternativas": ["Planning Poker", "Daily Stand-up", "Scrum of Scrums", "Kanban Flow"],
			"correta": 0
		},
		{
			"pergunta": "Como a priorização é feita no Product Backlog?",
			"alternativas": ["Pelo valor de negócio e urgência", "Pelo tamanho da equipe", "Pela ordem de criação", "Pela dificuldade técnica"],
			"correta": 0
		},
		{
			"pergunta": "Qual é o papel dos stakeholders no processo ágil?",
			"alternativas": ["Fornecer feedback e validar o produto", "Desenvolver funcionalidades", "Gerenciar a equipe", "Escrever o código"],
			"correta": 0
		}
	],
	"dificil": [
		{
			"pergunta": "Quem são os criadores do Manifesto Ágil?",
			"alternativas": ["Kent Beck, Jeff Sutherland e Robert C. Martin", "Jeff Sutherland, Ken Schwaber, Kent Beck e mais 14 desenvolvedores", "Alan Turing, Kent Beck e Ken Schwaber", "Robert C. Martin, Jeff Bezos e Steve Jobs"],
			"correta": 1
		},
		{
			"pergunta": "O que diferencia o Scrum do Kanban?",
			"alternativas": ["Scrum tem papéis definidos, Kanban não", "Kanban é iterativo, Scrum não", "Kanban tem Sprints fixas, Scrum não", "Scrum é baseado em filas, Kanban em tempo fixo"],
			"correta": 0
		},
		{
			"pergunta": "No Lean, o que significa 'Muda'?",
			"alternativas": ["Mudança", "Desperdício", "Iteração", "Refatoração"],
			"correta": 1
		},
		{
			"pergunta": "Qual destas métricas pode ser usada para medir a produtividade no Scrum?",
			"alternativas": ["Cycle Time", "Lead Time", "Velocity", "WIP Limit"],
			"correta": 2
		},
		{
			"pergunta": "No SAFe, o que é um PI Planning?",
			"alternativas": ["Planejamento de Incremento do Programa", "Reunião de Daily Scrum", "Backlog Refinement", "Definição do Product Backlog"],
			"correta": 0
		},
		{
			"pergunta": "Qual a principal diferença entre Scrum e Extreme Programming (XP)?",
			"alternativas": ["Scrum foca em gerenciamento de projetos e XP em práticas de engenharia", "XP utiliza Sprints e Scrum não", "Scrum tem retrospectivas e XP não", "XP é mais rígido e estruturado que o Scrum"],
			"correta": 0
		},
		{
			"pergunta": "Por que os times auto-organizados são fundamentais nas metodologias ágeis?",
			"alternativas": ["Eles garantem uma hierarquia fixa", "Incentivam a colaboração e a inovação", "Eliminam a necessidade de planejamento", "Substituem a liderança do Scrum Master"],
			"correta": 1
		},
		{
			"pergunta": "Qual a principal diferença entre os frameworks Scrum e Kanban?",
			"alternativas": ["Scrum tem Sprints definidos e Kanban é contínuo", "Kanban exige papéis específicos e Scrum não", "Scrum é usado apenas em desenvolvimento de software e Kanban não", "Kanban utiliza reuniões diárias obrigatórias e Scrum não"],
			"correta": 0
		},
		{
			"pergunta": "Como o Scrum Master pode lidar com impedimentos durante a Sprint?",
			"alternativas": ["Removendo obstáculos que atrapalham o time", "Delegando as tarefas para o Product Owner", "Ignorando os impedimentos e focando na entrega", "Aumentando a carga de trabalho dos desenvolvedores"],
			"correta": 0
		},
		{
			"pergunta": "Qual é a importância das reuniões diárias (Daily Scrum)?",
			"alternativas": ["Permitir a sincronização e identificação de impedimentos", "Definir as metas de longo prazo", "Revisar o desempenho individual dos membros", "Planejar férias e folgas"],
			"correta": 0
		},
		{
			"pergunta": "Em XP, qual prática é central para melhorar a qualidade do código?",
			"alternativas": ["Programação em par (Pair Programming)", "Trabalho remoto", "Reuniões semanais", "Documentação extensa"],
			"correta": 0
		},
		{
			"pergunta": "No SAFe, qual é o papel do Release Train Engineer (RTE)?",
			"alternativas": ["Facilitar a execução do Agile Release Train", "Definir os requisitos do produto", "Gerenciar a equipe de desenvolvimento", "Executar testes de qualidade"],
			"correta": 0
		},
		{
			"pergunta": "Qual métrica é frequentemente utilizada para medir a eficiência do time em metodologias ágeis?",
			"alternativas": ["Velocity", "Custo por hora", "Taxa de rotatividade", "Número de linhas de código"],
			"correta": 0
		},
		{
			"pergunta": "O que significa 'refactoring' em desenvolvimento ágil?",
			"alternativas": ["Melhorar o código sem alterar seu comportamento externo", "Adicionar novas funcionalidades ao sistema", "Remover códigos legados e obsoletos", "Escrever documentação técnica"],
			"correta": 0
		},
		{
			"pergunta": "Como a abordagem ágil lida com mudanças de requisitos durante o desenvolvimento?",
			"alternativas": ["Aceitando e incorporando mudanças de forma iterativa", "Congelando os requisitos após a primeira fase", "Ignorando mudanças para evitar retrabalho", "Adiando as mudanças para versões futuras"],
			"correta": 0
		}
	]
}

func _ready():
	# Conecta o botão de pular à função _on_skip_pressed, se ainda não estiver conectado.
	game_over_label.hide()  # Esconder o label no início
	skip_button.hide()
	question_panel.hide()
	skip_button.connect("pressed", Callable(self, "_on_skip_pressed"))
	skip_count = 1
	is_spin = false

func _on_btn_spin_pressed():
	# Impede que a roleta gire enquanto houver uma pergunta pendente.
	# Verifica se a roleta pode girar
	print("Botão de girar pressionado!")
	print("is_spin =", is_spin)
	if is_spin:
		print("A roleta já está girando, não pode girar novamente.")
		return  # Retorna se já estiver girando
	
	if question_panel.visible:
		print("Ainda há uma pergunta pendente!")
		show_feedback("Responda a pergunta ou use o pular para continuar.", Color(1, 1, 0))
		return

	if is_spin == false:
		is_spin = true
		var tween = get_tree().create_tween().set_parallel(true)
		
		# Quando a animação terminar, seleciona a dificuldade e a pergunta
		tween.connect("finished", func():
			var old_rotation_degrees = %front.rotation_degrees
			is_spin = false
			if old_rotation_degrees > 360:
				var rad_ = fmod(old_rotation_degrees, 360)
				%front.rotation_degrees = rad_
			
			# Define a dificuldade com base no ângulo final
			var difficulty = get_difficulty(reward_position)
			current_difficulty = difficulty
			# Seleciona uma pergunta aleatória da dificuldade definida
			if(difficulty=='zerar'):
				print("A roleta zerou seus pontos!")
				Global.score = 0
			else:
				var question = get_random_question(difficulty)
				print(question)
				
				# Exibe a pergunta e alternativas se houver alguma disponível
				show_question(question)  
				sig_reward.emit(question)
		)
		
		# Define um ângulo aleatório para o resultado da roleta
		reward_position = randi_range(0, 360)
		tween.tween_property(%front, "rotation_degrees", reward_position + 360 * speed * power, 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
		tween.finished


# Função para mapear o ângulo final para uma dificuldade
func _on_skip_pressed():
	# Só permite pular se houver uma pergunta ativa
	if question_panel.visible:
		skip_count += 1
		# Se atingir o máximo de pulos, encerra o jogo.
		if skip_count >= MAX_SKIPS:
			show_game_over()
			return
		# Exibe feedback informando que a pergunta foi pulada e oculta o painel.
		show_feedback("Pergunta pulada.", Color(0.5, 0.5, 1))
		question_panel.visible = false
		skip_button.hide() 
	else:
		# Se não houver pergunta ativa, pode exibir um aviso.
		show_feedback("Não há pergunta para pular.", Color(1, 1, 0))
		
func get_difficulty(angle):
	# Exemplo arbitrário:
	# 0 a 120 graus -> facil
	# 120 a 240 graus -> medio
	# 240 a 360 graus -> dificil
	if angle >= 0 and angle < 36:
		return "facil"
	elif angle >= 36 and angle < 72:
		return "medio"
	elif angle >= 72 and angle < 108:
		return "dificil"
	elif angle >= 108 and angle < 144:
		return "facil"
	elif angle >= 144 and angle < 180:
		return "medio"
	elif angle >= 180 and angle < 216:
		return "dificil"
	elif angle >= 216 and angle < 252:
		return "facil"
	elif angle >= 252 and angle < 288:
		return "medio"
	elif angle >= 288 and angle < 340:
		return "dificil"
	else:
		return "zerar"

# Função para selecionar uma pergunta aleatória de acordo com a dificuldade
func get_random_question(difficulty):
		
	if not questions.has(difficulty):
		print("dificuldade invalida", difficulty)
		return {}
		
	var arr = questions[difficulty]
	var index = randi() % arr.size()
	var selected_question = arr[index]
	
	# Remove a pergunta escolhida para que não seja reutilizada
	arr.remove_at(index)
	
	questions_generated[difficulty] += 1
	
	if questions_generated[difficulty] >= 15:
		game_over_label.visible = true
		show_game_over()
	

	print("escolhe a dificuldade:", difficulty)
	print("questao escolhida:",  selected_question)
	return selected_question


# Função para exibir a pergunta e as alternativas
func show_question(question):
	if question_label == null:
		print("question_label is null")
		return
	
	if option_buttons.size() == 0:
		print("option_buttons is empty or null")
		return
	if question.size() == 0:
		print("o dicionario esta vazio")
	
	question_label.text = question["pergunta"]  # Exibe a pergunta no label
	for i in range(option_buttons.size()):
		option_buttons[i].text = question["alternativas"][i]  # Define o texto dos botões
		if option_buttons[i].is_connected("pressed", Callable(self, "_on_option_selected")):
			option_buttons[i].disconnect("pressed", Callable(self, "_on_option_selected"))
		option_buttons[i].connect("pressed", Callable(self, "_on_option_selected").bind(i, question["correta"]))

	question_panel.visible = true  # Torna o painel de perguntas visível
	skip_button.show() 

func show_feedback(message: String, color: Color):
	feedback_popup.visible = true
	
	# Acesse o Label dentro do feedback_popup (substitua "YourLabel" pelo nome do nó que você está usando)
	var feedback_label = feedback_popup.get_node("YourLabel")  # Altere "YourLabel" para o nome do seu nó
	if feedback_label:
		feedback_label.text = message  # Define a mensagem
		feedback_label.add_color_override("font_color", color)  # Altera a cor do texto

	# Define a posição do feedback_popup na tela
	var viewport_size = get_viewport().get_visible_rect().size
	feedback_popup.position = Vector2((viewport_size.x - feedback_popup.size.x) / 2, 20)

	# Aguarda 2 segundos antes de ocultar o feedback_popup
	await get_tree().create_timer(2).timeout
	feedback_popup.visible = false  
	
# Função para verificar a resposta selecionada
func _on_option_selected(selected_index, correct_index):
	# Define os pontos com base na dificuldade atual
	var points_to_gain = 0
	match current_difficulty:
		"facil":
			points_to_gain = 50
		"medio":
			points_to_gain = 100
		"dificil":
			points_to_gain = 200
		_:
			points_to_gain = 0

	if selected_index == correct_index:
		print("Resposta correta!")
		Global.score += points_to_gain
		score_label.text = "Pontuação: " + str(Global.score)
		show_feedback("Isso ai!", Color(0, 1, 0))
	else:
		print("Resposta incorreta!")
		Global.score -= points_to_gain / 2  # Perde metade dos pontos que ganharia se acertasse
		if Global.score < 0:  # Garante que a pontuação não fique negativa
			Global.score = 0
		score_label.text = "Pontuação: " + str(Global.score)
		show_feedback("Não foi dessa vez :(", Color(0.5, 0, 0))

	question_panel.visible = false  # Oculta o painel de pergunta

	# Verifica se o jogador ganhou o jogo
	if Global.score >= 1000:
		game_over_label.bbcode_enabled = true
		game_over_label.text = "[color=green]VOCE GANHOU![/color]"
		game_over_label.show()
		skip_button.disabled = true
		for button in option_buttons:
			button.disabled = true
		reset_question_counters()

func game_over(message):
	# Exibe o feedback de game over (pode ser um popup, mudança de cena, etc.)
	show_feedback(message, Color(1, 0, 0))
	# Aqui você pode adicionar a lógica para mudar de cena ou desabilitar a roleta
	print("Game Over: " + message)
	
func show_game_over():
	game_over_label.show()
	skip_button.disabled = true
	for button in option_buttons:
		button.disabled = true
	reset_question_counters()
	
func reset_question_counters():
	questions_generated["facil"] = 0
	questions_generated["medio"] = 0
	questions_generated["dificil"] = 0
