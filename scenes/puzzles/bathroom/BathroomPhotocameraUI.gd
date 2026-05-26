extends Control

const FADE_DURATION = 0.3
const CORRECT_PASSWORD = "1234"

@onready var commonMenu: Control = %CommonMenu
@onready var passwordMenu: Control = %PasswordMenu
@onready var photosListMenu: Control = %PhotosListMenu
@onready var photoZoomMenu: Control = %PhotoZoomMenu
@onready var blackRect: ColorRect = %BlackRect
@onready var passwordInput: LineEdit = %PasswordMenu.get_node("ScrollContainer/VBoxContainer/HBoxContainer/PasswordInput")

func _ready() -> void:
	var commonVBox = %CommonMenu.get_node("ScrollContainer/VBoxContainer")
	commonVBox.get_node("TakeAPhotoButton").pressed.connect(onTakeAPhotoPressed)
	commonVBox.get_node("GalleryButton").pressed.connect(func(): fadeToMenu(passwordMenu))
	commonVBox.get_node("ExitButton").pressed.connect(onExitPressed)

	var passwordVBox = %PasswordMenu.get_node("ScrollContainer/VBoxContainer")
	passwordVBox.get_node("GalleryButton").pressed.connect(onPasswordEnterPressed)
	%PasswordMenu.get_node("BackButton").pressed.connect(func(): fadeToMenu(%CommonMenu))

	var photosVBox = %PhotosListMenu.get_node("ScrollContainer/VBoxContainer")
	photosVBox.get_node("photo01").pressed.connect(func(): fadeToMenu(photoZoomMenu))
	photosVBox.get_node("photo02").pressed.connect(func(): fadeToMenu(photoZoomMenu))
	%PhotosListMenu.get_node("BackButton").pressed.connect(func(): fadeToMenu(%CommonMenu))

	%PhotoZoomMenu.get_node("Control/BackButton").pressed.connect(func(): fadeToMenu(photosListMenu))

func fadeToMenu(targetMenu: Control) -> void:
	var tweenIn = create_tween()
	tweenIn.tween_property(blackRect, "color:a", 1.0, FADE_DURATION)
	tweenIn.finished.connect(func():
		hideAllMenus()
		targetMenu.visible = true
		var tweenOut = create_tween()
		tweenOut.tween_property(blackRect, "color:a", 0.0, FADE_DURATION)
	, CONNECT_ONE_SHOT)

func hideAllMenus() -> void:
	commonMenu.visible = false
	passwordMenu.visible = false
	photosListMenu.visible = false
	photoZoomMenu.visible = false

func onPasswordEnterPressed() -> void:
	if passwordInput.text == CORRECT_PASSWORD:
		passwordInput.text = ""
		passwordInput.placeholder_text = "password"
		fadeToMenu(photosListMenu)
	else:
		passwordInput.text = ""
		passwordInput.placeholder_text = "incorrect"

func onTakeAPhotoPressed() -> void:
	PuzzleStates.bathroomDollPuzzleLogic.checkPhoto();
	Dialogic.start("BathroomPhotocameraUse", "takePhoto");

func onExitPressed() -> void:
	PuzzleStates.finishPuzzle()
