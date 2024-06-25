extends Node

class_name GameData

var current_region = -1
var current_level = -1
var total_mangoes_collected = -1
var collected_mango_ids = []
var completed_level_ids = []
	

static func custom_property_filter(property):
	return property.type == 0 && property.hint_string == ""
	
