# MainEventBus
extends Node

signal level_changed();
signal level_change(level: PackedScene);

signal usable_object_is_hovered(usable_object: Node2D);
signal usable_object_is_unhovered(usable_object: Node2D);

signal grabable_object_is_hovered(grabable_object: Node2D);
signal grabable_object_is_unhovered(grabable_object: Node2D);

#images
signal image_layer_show_image(image: Texture2D)
signal image_layer_exit()
signal image_layer_showed()
signal image_layer_hidden()

#markers
signal send_player_to_marker(marker: Marker2D)
