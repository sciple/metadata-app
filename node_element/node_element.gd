extends GraphNode

var created_at
var node_type


func _ready():
	print()
	# timestamp for node creation
	created_at = Time.get_datetime_string_from_system ()
	print(self.title, " created at: ", created_at)
	
	# every inherited node must belong to a group
	node_type = self.get_groups()[0]
	print(self.node_type, " node type: ", node_type)
	print()



func register_node_creation():
	Global.node_elements[self.title] = {}

func register_position():
	Global.node_elements[self.title]["position"] = self.position_offset
	return self.position_offset

func register_creation_date():
	Global.node_elements[self.title]["created_at"] = self.created_at

func register_node_type():
	Global.node_elements[self.title]["type"] = self.node_type

func update_node():
	self.register_node_creation()
	self.register_creation_date()
	self.register_position()
	self.register_node_type()
