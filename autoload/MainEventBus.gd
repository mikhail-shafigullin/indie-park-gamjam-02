# MainEventBus
extends Node

signal level_changed();
signal level_change(level: Level);

signal usable_object_is_hovered(usable_object: Node2D);
signal usable_object_is_unhovered(usable_object: Node2D);

signal grabable_object_is_hovered(grabable_object: Node2D);
signal grabable_object_is_unhovered(grabable_object: Node2D);
signal grabable_object_grabbed(grabable_object: Node2D)
signal grabable_object_released(grabable_object: Node2D)
signal grabable_object_is_placed_on_trigger(trigger: TriggerOnGrabable, grabable_object: Node2D)

#images
signal image_layer_show_image(image: Texture2D)
signal image_layer_exit()
signal image_layer_showed()
signal image_layer_hidden()

#markers
signal send_player_to_marker(marker: Marker2D)

#puzzles
signal puzzle_1_1_solved()
signal puzzle_1_2_solved()
signal puzzle_1_3_solved()
signal puzzle_2_solved()
signal puzzle_3_solved()
signal puzzle_4_solved()

#inventory
signal inventory_opened();
signal inventory_closed();
signal inventory_add_item(item: InventoryItem);
