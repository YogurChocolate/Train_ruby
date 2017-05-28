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
    path_length=0
    nodes_arr=nodes.split('')
    (0...nodes_arr.length-1).each do |i|
      pre_node=nodes_arr[i]
      next_node=nodes_arr[i+1]
      can_arive_node_and_lenth=@store[pre_node]

      can_arive_node_and_lenth.each do |one_path|
        if one_path[0]==next_node
          path_length+=one_path[1].to_i
        end
      end
    end
    return path_length
  end

end