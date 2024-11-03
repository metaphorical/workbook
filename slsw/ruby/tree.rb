class Tree
	attr_accessor :children, :node_name

	def initialize(name, children=[])
		@children = children
		@node_name = name
	end

	def visit_all(&block)
		visit &block
		children.each { |c| c.visit_all &block}
	end

	def visit(&block)
		block.call self
	end

	# @todo - implement draw_tree
end

drvo = Tree.new("Drvo br 1", [Tree.new("Grana 1"), Tree.new("Grana 2"), Tree.new("Grana 3")])

puts "Obilazim drvo"
drvo.visit { |grana| puts grana.node_name}
puts "\n"

puts "Obilazim celo drvo i grane"
drvo.visit_all {|grana| puts grana.node_name}