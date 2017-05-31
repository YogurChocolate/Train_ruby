class GraphHandler
  @store
  @already_find_one_shortest_route
  @already_find_routes_num
  attr_accessor :store, :already_find_routes_num


  def initialize(graph)
    @store=graph.store
    @already_find_one_shortest_route=65535
    @already_find_routes_num=0
  end


  def get_route_distance route
    route_distance=0
    nodes=route.split('')
    (0...nodes.length-1).each do |i|
      pre_node=nodes[i]
      next_node=nodes[i+1]
      is_reachable=false
      @store[pre_node].each do |node_distance|
        if node_distance[0]==next_node
          is_reachable=true
          route_distance+=node_distance[1]
          break
        end
      end
      if !is_reachable
        return 'NO SUCH ROUTE'
      end
    end
    return route_distance
  end


  def get_trips_num_with_max_stops (start_node, end_node, max_stops)
    get_trips_num_with_max_or_exactly_stops(start_node,end_node,max_stops,true)
  end

  def get_trips_num_with_exactly_stops (start_node, end_node, exactly_stops)
    get_trips_num_with_max_or_exactly_stops(start_node,end_node,exactly_stops,false)
  end



  def get_shortest_route_length(start_node, end_node, already_pass_route_length=0)
    if @already_find_one_shortest_route < already_pass_route_length
      return
    end

    if start_node==end_node && already_pass_route_length!=0
      @already_find_one_shortest_route=already_pass_route_length
      return
    end

    @store[start_node].each do |one_path|
      get_shortest_route_length(one_path[0], end_node, already_pass_route_length+one_path[1])
    end
    return @already_find_one_shortest_route
  end


  def get_different_routes_num(start_node, end_node, max_route_length, already_pass_route_length=0)
    @already_find_routes_num=0
    get_different_routes_num_function(start_node, end_node, max_route_length, already_pass_route_length)
    return @already_find_routes_num
  end


  private

  def get_trips_num_with_max_or_exactly_stops(start_node, end_node, stops, is_stops_max)
    trips_num=0
    if stops<0
      return 0
    end

    if start_node==end_node && (stops==0||is_stops_max)
      trips_num+=1
    end

    @store[start_node].each do |node_distance|
      trips_num+=get_trips_num_with_exactly_stops(node_distance[0], end_node, stops-1)
    end
    return trips_num
  end


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
