require 'rspec'
require './src/graph'

routes_distances=['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']

describe 'graph has inited by given routes_distances' do
  graph = Graph.new(routes_distances)

  it 'graph should stored by expect value' do
    expect_store={"A"=>[["B", 5], ["D", 5], ["E", 7]], "B"=>[["C", 4]], "C"=>[["D", 8], ["E", 2]], "D"=>[["C", 8], ["E", 6]], "E"=>[["B", 3]]}
    expect(graph.store).to eql expect_store
  end

end