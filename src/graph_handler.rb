class GraphHandler
  MAX_ROUTE_LEN=200
  attr_accessor :store

  def initialize(graph)
    @store=graph.store
    @already_find_one_shortest_route=MAX_ROUTE_LEN
    @already_find_routes_num=0
  end


  def compute_route_distance route
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


  def compute_trips_num_with_max_stops (start_node, end_node, max_stops)
    compute_trips_num_with_max_or_exactly_stops(start_node, end_node, max_stops, true)
  end

  def compute_trips_num_with_exactly_stops (start_node, end_node, exactly_stops)
    compute_trips_num_with_max_or_exactly_stops(start_node, end_node, exactly_stops, false)
  end

  def get_shortest_route_length(start_node, end_node, already_past_route_length=0)
    @already_find_one_shortest_route=MAX_ROUTE_LEN
    return compute_shortest_routes_length_function(start_node, end_node, already_past_route_length)
  end

  def compute_different_routes_num(start_node, end_node, less_than_length, already_past_length=0)
    @already_find_routes_num=0
    compute_different_routes_num_function(start_node, end_node, less_than_length, already_past_length)
    return @already_find_routes_num
  end


  private

  def compute_trips_num_with_max_or_exactly_stops(start_node, end_node, stops, is_max_stops)
    trips_num=0
    if stops<0
      return 0
    end

    if start_node==end_node && (stops==0||is_max_stops)
      trips_num+=1
    end

    @store[start_node].each do |node_distance|
      trips_num+=compute_trips_num_with_exactly_stops(node_distance[0], end_node, stops-1)
    end
    return trips_num
  end


  def compute_different_routes_num_function(start_node, end_node, max_route_length, already_past_route_length)
    if already_past_route_length>=max_route_length
      return
    end

    if start_node==end_node && already_past_route_length!=0
      @already_find_routes_num+=1
    end

    @store[start_node].each do |one_path|
      compute_different_routes_num_function(one_path[0], end_node, max_route_length, already_past_route_length+one_path[1])
    end
  end


  def compute_shortest_routes_length_function(start_node, end_node, already_past_route_length=0)
    if @already_find_one_shortest_route < already_past_route_length
      return
    end

    if start_node==end_node && already_past_route_length!=0
      @already_find_one_shortest_route=already_past_route_length
      return
    end

    @store[start_node].each do |one_path|
      compute_shortest_routes_length_function(one_path[0], end_node, already_past_route_length+one_path[1])
    end
    return @already_find_one_shortest_route
  end

end
