require 'spec_helper'

describe Spot do
  #pending "add some examples to (or delete) #{__FILE__}"
  it "create with caretaker and project" do 
    sp = Spot.new
    sp.caretaker.should_not == nil
    sp.project.should_not == nil
  end

end
