require 'spec_helper'

describe Collection do
  it 'should represent valid collection data' do
    expect { Collection.new(:name => '').save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect { Collection.new.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
