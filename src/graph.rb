class Graph
  @store
  attr_accessor :store

  def initialize (input_data)
    @store=Hash.new
    storePath input_data
  end

  def storePath nodes_and_distance
    (0...nodes_and_distance.length).each do |i|
      one_path=nodes_and_distance[i]
      start_node=one_path[0]
      end_node=one_path[1]
      distance=one_path[2].to_i

      if !@store.has_key?(start_node)
      then
        @store[start_node]=[[end_node, distance]]
      else
        @store[start_node]= @store[start_node]+[[end_node, distance]]
      end
    end
  end

end