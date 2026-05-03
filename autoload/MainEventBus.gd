# MainEventBus
extends Node

signal level_changed();

signal usable_object_is_hovered(usable_object: Node2D);
signal usable_object_is_unhovered(usable_object: Node2D);

signal grabable_object_is_hovered(grabable_object: Node2D);
signal grabable_object_is_unhovered(grabable_object: Node2D);

# animations
signal animation_fade_in_to_object(obj: Node2D);
signal animation_fade_in_finished();
signal animation_fade_out_from_object(obj: Node2D);
signal animation_fade_out_finished();
