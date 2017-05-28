require 'rspec'
require '~/ruby/Train_ruby/spec/graph.rb'


describe 'graph inited' do

  graph = Graph.new

  it 'graph should stored by excpte value' do
    excpte_store={"A"=>[["B", "5"], ["D", "5"], ["E", "7"]], "B"=>[["C", "4"]], "C"=>[["D", "8"], ["E", "2"]], "D"=>[["C", "8"], ["E", "6"]], "E"=>[["B", "3"]]}
    expect(graph.store).to eql excpte_store
  end

  it 'The distance of the route A-B-C should be 9' do
    expect(graph.getlength('ABC')).to eql 9
  end

  it 'The distance of the route A-D should be 5' do
    expect(graph.getlength('AD')).to eql 5
  end

end