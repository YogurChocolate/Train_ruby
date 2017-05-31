class GraphHandler
  @store
  @already_find_one_shortest_route
  @already_find_routes_num
  attr_accessor :store, :already_find_one_shortest_route, :already_find_routes_num


  def initialize(graph)
    @store=graph.store
    @already_find_one_shortest_route=65535
    @already_find_routes_num=0
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


  def get_shortest_route(start_node, end_node, already_pass_route_length=0)
    if @already_find_one_shortest_route < already_pass_route_length
      return
    end

    if start_node==end_node && already_pass_route_length!=0
      @already_find_one_shortest_route=already_pass_route_length
      return
    end

    @store[start_node].each do |one_path|
      get_shortest_route(one_path[0], end_node, already_pass_route_length+one_path[1])
    end
    return @already_find_one_shortest_route
  end


  def get_different_routes_num(start_node, end_node, max_route_length, already_pass_route_length=0)
    @already_find_routes_num=0
    get_different_routes_num_function(start_node, end_node, max_route_length,already_pass_route_length)
    return @already_find_routes_num
  end


    private

    def get_different_routes_num_function(start_node, end_node, max_route_length, already_pass_route_length)
      if already_pass_route_length>=max_route_length
        return
      end

      if start_node==end_node && already_pass_route_length!=0
        @already_find_routes_num+=1
      end

      @store[start_node].each do |one_path|
        get_different_routes_num_function(one_path[0], end_node, max_route_length, already_pass_route_length+one_path[1])
      end
    end

  end
