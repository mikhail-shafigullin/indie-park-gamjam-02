extends Node

const outro_res := preload("uid://7reuemj3eauw")
#res://levels/gameOver/GameOverCreditsLevel.tscn
const gameOverCreditsLevel := preload("uid://cwh7qpfciv0v1");

var player: PlayerController;

var currentPuzzle: Control;

var main_screen: MainScreen;

var intro_screen: IntroScreen;

var outro_screen;

func end_the_game():
	var level = gameOverCreditsLevel.instantiate();
	main_screen.setLocation(level);
