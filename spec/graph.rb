class Graph
  @store
  @already_find_one_shortest_route
  attr_accessor :store ,:already_find_one_shortest_route


  def initialize
    nodes_and_distance= ['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']
    storePath nodes_and_distance
    @already_find_one_shortest_route=65535
  end


  def storePath nodes_and_distance
    @store=Hash.new
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


  def get_length nodes
    path_length=0
    nodes_arr=nodes.split('')
    (0...nodes_arr.length-1).each do |i|
      pre_node=nodes_arr[i]
      next_node=nodes_arr[i+1]
      can_arive_node_and_lenth=@store[pre_node]

      is_available=false
      can_arive_node_and_lenth.each do |one_path|
        if one_path[0]==next_node
          is_available=true
          path_length+=one_path[1].to_i
          break
        end
      end
      if !is_available
        return 'NO SUCH ROUTE'
      end
    end
    return path_length
  end


  def get_path_num_within_max_node (start_node, end_node, max_stop)
    path_num=0
    if max_stop<0
      return 0
    end
    if start_node==end_node
      path_num+=1
    end

    @store[start_node].each do |one_path|
      path_num+=get_path_num_within_max_node(one_path[0], end_node, max_stop-1).to_i
      return path_num
    end
  end


  def get_path_num_within_exactly_node (start_node, end_node, exactly_stop)
    path_num=0
    if exactly_stop<0
      return 0
    end

    if start_node==end_node && exactly_stop==0
      path_num+=1
    end

    @store[start_node].each do |one_path|
      path_num+=get_path_num_within_exactly_node(one_path[0], end_node, exactly_stop-1).to_i
    end
    return path_num
  end



  def get_shortest_route(start_node,end_node,already_pass_route_length=0)
    require 'byebug'; byebug;
    if @already_find_one_shortest_route < already_pass_route_length
      return
    end

    if start_node==end_node
      @already_find_one_shortest_route=already_pass_route_length
      return
    end

    @store[start_node].each do |one_path|
      get_shortest_route(one_path[0],end_node,already_pass_route_length+one_path[1])
    end
    return @already_find_one_shortest_route
  end

end
