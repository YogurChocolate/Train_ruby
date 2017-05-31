require 'rspec'
require './src/graph_handler'
require './src/graph'

input_value=['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']

describe 'graph inited by given input_value' do
  graph = Graph.new(input_value)
  graph_handler=GraphHandler.new(graph)

  it 'Get length of exist route should return right distance' do
    expect(graph_handler.get_route_distance('ABC')).to eql 9
    expect(graph_handler.get_route_distance('AD')).to eql 5
    expect(graph_handler.get_route_distance('ADC')).to eql 13
    expect(graph_handler.get_route_distance('AEBCD')).to eql 22
  end

  it 'Get length of not exist route should return NO SUCH ROUTE' do
    expect(graph_handler.get_route_distance('AED')).to eql 'NO SUCH ROUTE'
  end

  it 'Get path num within max stop of start and end node same should retrun right path num' do
    expect(graph_handler.get_trips_num_with_max_stops('C', 'C', 3)).to eql 2
  end

  it 'Get path num within max stop of start and end node different should retrun right path num' do
    expect(graph_handler.get_trips_num_with_exactly_stops('A', 'C', 4)).to eql 3
  end

  it 'Get shortest route length of the start and end node different should retrun right' do
    expect(graph_handler.get_shortest_route_length('A', 'C', 0)).to eql 9
  end

  it 'Get shortest route length of the start and end node same should retrun right' do
    expect(graph_handler.get_shortest_route_length('B', 'B', 0)).to eql 9
  end

  it 'Get different routes num within max route length should be right' do
    expect(graph_handler.get_different_routes_num('C','C',30)).to eql 7
  end

end