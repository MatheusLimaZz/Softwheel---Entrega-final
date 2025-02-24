# Softwheel---Entrega-final

Jogo para o projeto final da disciplina Extensão 2 - Softwheel.

## Descrição

Softwheel é um jogo de quiz sobre temas da área de engenharia de software. O objetivo é revisar e desafiar seus conhecimentos nos subtemas da engenharia de software através de perguntas de diferentes níveis de dificuldade.

## Como Jogar

- Toda rodada você terá que girar a roleta para definir o nível de dificuldade da pergunta: fácil, médio ou difícil.
- Questões fáceis valem 50 pontos, médias valem 100 e difíceis valem 200.
- Você ganha o jogo ao atingir 1000 pontos.
- Errar uma questão faz você perder pontos igual a metade do que você ganharia caso acertasse a questão.

## Executável

O executável do jogo está disponível no arquivo `jogo_atualizado.exe`. Basta executá-lo para iniciar o jogo.

## Alterando o Projeto

Para alterar o projeto, você precisará do Godot Engine. Siga os passos abaixo para baixar e configurar o Godot Engine:

1. Acesse o site oficial do Godot Engine: [godotengine.org](https://godotengine.org)
2. Baixe a versão mais recente do Godot Engine compatível com o seu sistema operacional.
3. Instale o Godot Engine seguindo as instruções fornecidas no site.
4. Abra o Godot Engine e importe o projeto localizado na pasta `jogodaroletaatt`.

## Estrutura do Projeto

- `addons/`: Contém addons utilizados no projeto.
- `button_ativar_roleta.gd`, `button.gd`, `buttonStart.gd`: Scripts para os botões do jogo.
- `color_rect_escolher_tema.gd`, `color_rect_escolherquantidade.gd`, etc.: Scripts para os elementos visuais do jogo.
- `Escolherquantidadejogadorescontrol.tscn`, `escolhertemacontrol.tscn`: Cenas do jogo.
- `export_presets.cfg`: Configurações de exportação do projeto.
- `Global.gd`: Script global do jogo.
- `imagem/`: Contém imagens utilizadas no jogo.
- `README.md`: Este arquivo de documentação.

## Licença

Este projeto é desenvolvido para fins educacionais e não possui uma licença específica. O jogo é livre para se fazer quaisquer alterações.

## Recomendações e possíveis futuros trabalhos

As perguntas estão atreladas a um arquivo JSON, logo, para adicionar mais seções de perguntas ou modificar elas, basta trabalhar com esse arquivo, ou implementar um banco de dados não relacional.