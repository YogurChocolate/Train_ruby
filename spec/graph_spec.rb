require 'rspec'
require '~/ruby/Train_ruby/spec/graph.rb'


describe 'graph inited' do

  graph = Graph.new
  require 'byebug'; byebug;
  it 'get path len of abc is should 9' do
    excpte_store={"A"=>[["B", "5"], ["D", "5"], ["E", "7"]], "B"=>[["C", "4"]], "C"=>[["D", "8"], ["E", "2"]], "D"=>[["C", "8"], ["E", "6"]], "E"=>[["B", "3"]]}
    expect(graph.store).to eql excpte_store
  end

end