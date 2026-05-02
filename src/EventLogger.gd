extends Node


func _ready() -> void:
	var bus := MainEventBus

	var baseSignals := {}
	for sig in ClassDB.class_get_signal_list("Node", false):
		baseSignals[sig["name"]] = true

	for sig in bus.get_signal_list():
		var sigName: String = sig["name"]
		if baseSignals.has(sigName):
			continue
		var argCount: int = sig["args"].size()
		var signalObject: Signal = bus[sigName]
		if argCount == 0:
			signalObject.connect(logEvent.bind(sigName))
		else:
			signalObject.connect(logEventWithArg.bind(sigName))


func logEvent(eventName: String) -> void:
	print("[EventLogger] %s" % eventName)

func logEventWithArg(_arg: Variant, eventName: String) -> void:
	print("[EventLogger] %s" % eventName)
