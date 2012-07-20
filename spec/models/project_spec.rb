require 'spec_helper'

describe Project do
  before :all do
  end
  before :each do
  end
  it 'should have spots' do
    pj = FactoryGirl.create(:project_j)
    pf.size.should == 2
  end
  it 'should be able to convert datum of spots' do
    
  end
end
