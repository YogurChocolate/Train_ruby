class Graph
  @store
  attr_accessor :store

  def initialize (routes_distances)
    @store=Hash.new
    storePath routes_distances
  end

  def storePath routes_distances
    (0...routes_distances.length).each do |i|
      one_route_distance=routes_distances[i]
      start_node=one_route_distance[0]
      end_node=one_route_distance[1]
      distance=one_route_distance[2].to_i

      if !@store.has_key?(start_node)
      then
        @store[start_node]=[[end_node, distance]]
      else
        @store[start_node]= @store[start_node]+[[end_node, distance]]
      end
    end
  end

end