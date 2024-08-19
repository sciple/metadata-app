extends "res://node_element/node_element.gd"

var node_specific_connections =[]
var selection_color

func _ready():
	selection_color = Global.assign_treatment_color()
	self.self_modulate =self.selection_color


func _on_node_selected():
	
	var tmp_connections = Global.get_cage_connections()
	var tmp_all_children = Global.main_graph.get_children()
	
	# make sure that only cages connected to self are retained
	for con in tmp_connections: # search trhough all connections
		if self.name in con["from_node"]: # get only connections from self
			node_specific_connections.append(con)
	
	print()
	print("node specific connections",node_specific_connections)
	
	#if len(node_specific_connections) > 0:
	for con in node_specific_connections:
		var tmp_cage = Global.main_graph.get_node(NodePath(con["to_node"]))
		print(tmp_cage)
		if tmp_cage != null:
			tmp_cage.change_color(node_specific_connections, self.selection_color)
	

func _on_node_deselected():
	
	print("Deselected")
	for con in node_specific_connections:
		var tmp_cage = Global.main_graph.get_node(NodePath(con["to_node"]))
		print(tmp_cage)
		if tmp_cage != null:
			tmp_cage.revert_color(node_specific_connections)
