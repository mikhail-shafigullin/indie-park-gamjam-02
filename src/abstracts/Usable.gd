class_name Usable
extends Node2D

signal _object_used;
signal _object_disabled;
signal _object_enabled;

@export var isDisable: bool;

func useObjectWithSignal():
	if(isDisable):
		return;
	useObject();
	_object_used.emit();

func useObject():
	assert(false, "Usable object doesn't have useObject() method");

func onHover():
	pass;

func onUnhover():
	pass;

func disable():
	isDisable = true;
	_object_disabled.emit();
	
func enable():
	isDisable = false;
	_object_enabled.emit();
