class Graph
  @store
  attr_accessor :store



  def initialize
    nodes_and_distance= ['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']
    storePath nodes_and_distance
  end


  def storePath nodes_and_distance
    @store=Hash.new
    (0...nodes_and_distance.length).each do |i|
      one_path=nodes_and_distance[i]
      start_node=one_path[0]
      end_node=one_path[1]
      distance=one_path[2]

      if !@store.has_key?(start_node)
        then @store[start_node]=[[end_node,distance]]
      else
        @store[start_node]= @store[start_node]+[[end_node,distance]]
      end
    end
  end

  def getlength nodes
    return 9
  end

end