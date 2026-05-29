extends Node

const outro_res := preload("uid://7reuemj3eauw")

var player: PlayerController;

var currentPuzzle: Control;

var main_screen: MainScreen;

var intro_screen: IntroScreen;

var outro_screen;

func end_the_game():
    main_screen.queue_free()
    outro_screen = outro_res.instantiate()
    get_parent().add_child(outro_screen)