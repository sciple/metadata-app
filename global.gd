extends Node

var global_index = -1
var cage_index = -1
var experiment_index = -1
var parent_index = -1
var health_index = -1
var comment_index = -1
var treatment_index = -1
var operator_index = -1
var node_elements = {}

var total_number_of_subjects = 0
var cages = {}

var cage_node = load("res://cage_plus/cage_plus.tscn")
#var experiment_node = load("res://experiment/experiment.tscn")
var experiment_node = load("res://experiment_plus/experiment_plus.tscn")
var parent_node = load("res://cage/parent_cage.tscn")
#var health_node = load("res://health/health.tscn")
var health_node = load("res://health_plus/health_plus.tscn")
var comment_node = load("res://comment/comment.tscn")
var treatment_node = load("res://treatment/treatment.tscn")
var operator_node = load("res://operator/operator.tscn")



func create_node(node_name, node_type, node_index):
	var node = node_type.instantiate()
	node_index += 1
	get_node("../Main/GraphEdit").add_child(node)
	node.name = node_name + "_" + str(node_index)

func init_node_elements():
	self.node_elements = {}

func init_subjects():
	self.cages = {}
	self.total_number_of_subjects = 0


