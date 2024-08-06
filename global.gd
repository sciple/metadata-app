extends Node

var global_index = -1
var cage_index = -1
var experiment_index = -1
var parent_index = -1
var health_index = -1
var comment_index = -1
var treatment_index = -1
var operator_index = -1
var genotype_index = -1
var node_elements = {}

var total_number_of_subjects = 0
var cages = {}

var cage_node = load("res://cage_plus/cage_plus.tscn")
var experiment_node = load("res://experiment_plus/experiment_plus.tscn")
var health_node = load("res://health_plus/health_plus.tscn")
var comment_node = load("res://comment_plus/comment_plus.tscn")
var treatment_node = load("res://treatment/treatment.tscn")
var operator_node = load("res://operator/operator.tscn")
var genotype_node = load("res://genotype/genotype.tscn")

var main_graph

var red_color = Color.hex(0xff2f40ff)
var blue_color = Color.hex(0x709124ff)


func _ready():
	# get the main node graph to enable foreign access
	var tmp = get_tree().root.get_node("Main")
	main_graph = tmp.get_node("GraphEdit")

func create_node(node_name, node_type, node_index, node_position=Vector2(50,50), node_group="generic"):
	var node = node_type.instantiate()
	node_index += 1
	get_node("../Main/GraphEdit").add_child(node)
	node.position_offset = node_position
	node.name = node_name + "_" + str(node_index)
	node.add_to_group(node_group)

func init_node_elements():
	self.node_elements = {}

func init_subjects():
	self.cages = {}
	self.total_number_of_subjects = 0
