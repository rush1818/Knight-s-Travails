require './00_tree_node.rb'
class KnightPathFinder
  attr_reader :visited_positions
  def initialize(pos)
    @start_position = PolyTreeNode.new(pos)
    # @root = PolyTreeNode.new(pos)
    @visited_positions = [@start_position]
    # @grid = Array.new(8) {Array.new(8)}
  end

  def build_move_tree
    queue = [@start_position]
    i = 0
    until queue.empty?
      p i+=1
      current_pos = queue.shift
      queue.concat(new_move_positions(current_pos))
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
    new_positions.reject! {|obj| @visited_positions.include?(obj) }
    new_positions.each { |node| node.parent = pos }
    @visited_positions.concat(new_positions)
    new_positions
  end

  def find_path(end_pos)
    build_move_tree
    @visited_positions.each
  end

  def trace_path_back
  end

end
