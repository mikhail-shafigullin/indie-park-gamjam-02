class_name Level
extends Node

var markers: Dictionary[String, Marker2D];

func sendPlayerToMarker(name: String):
	if(markers.is_empty()):
		populateMarkers();
	MainEventBus.level_change.emit(self)
	MainEventBus.level_changed.connect(
		func(): MainEventBus.send_player_to_marker.emit(markers.get(name)),
		CONNECT_ONE_SHOT
	)

func populateMarkers():
	var el = find_children("*", "Marker2D", true, false);
	for child in find_children("*", "Marker2D", true, false):
		markers[child.name] = child

func getMarker(name: String) -> Marker2D:
	if(markers.is_empty()):
		populateMarkers();
	return markers.get(name);
