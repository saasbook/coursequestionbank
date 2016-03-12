require 'spec_helper'

describe Collection do
  it 'should represent valid collection data' do
    expect { Collection.new(:name => '').save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect { Collection.new.save! }.to raise_error(ActiveRecord::RecordInvalid)
    
  end
  
  describe 'add_problem' do
    it 'should add a problem to the collection' do
      collection = Collection.new
      problem = Problem.new
      collection.add_problem(problem)
      expect(collection.problems).to include(problem)
    end
  end
end
