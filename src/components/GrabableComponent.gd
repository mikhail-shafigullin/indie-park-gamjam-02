class_name GrabableComponent
extends Node

signal grabbed
signal released

func onGrab() -> void:
	grabbed.emit()

func onRelease() -> void:
	released.emit()
