require './00_tree_node.rb'
class KnightPathFinder
  attr_reader :visited_positions
  def initialize(pos)
    @start_position = PolyTreeNode.new(pos)
    # @root = PolyTreeNode.new(pos)
    @visited_positions = [@start_position]  #array of Node objects
    # @grid = Array.new(8) {Array.new(8)}
  end

  def build_move_tree
    queue = [@start_position]
    until queue.empty?
      current_node = queue.shift
      queue.concat(new_move_positions(current_node))
    end
  end

  def self.valid_moves(pos) #pos is an Array
    row, col = pos
    inc = [-2,-1,1,2]
    valids = []
    inc.each do |idx|
      inc.each do |jdx|
        next if idx.abs == jdx.abs
        valids << [row+idx, col+jdx]
      end
    end
    valids.select{|coord| coord[0].between?(0,7) && coord[1].between?(0,7)}
  end


  def new_move_positions(pos)   #pos is a PolyTreeNode object
    new_positions = self.class.valid_moves(pos.value).map {|coord| PolyTreeNode.new(coord)}
    new_answer = []
    new_positions.each do |child|
      valid_child = true
      @visited_positions.each do |parent|
        valid_child = false if parent.value == child.value
      end
      new_answer << child if valid_child
    end
    new_answer.each { |node| node.parent = pos }
    @visited_positions.concat(new_answer)
    p new_answer #Array of objects
  end

  def find_path(end_pos)
    build_move_tree
    @visited_positions.each
  end

  def trace_path_back
  end

  def print_objects
    @visited_positions.each do |obj|
      p "current object: #{obj.value}"

      unless obj.parent.nil?
        p "parent: #{obj.parent.value}"
      end

      p "-"*15
    end
    ""
  end

end
