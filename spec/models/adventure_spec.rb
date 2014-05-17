require 'spec_helper'

describe Adventure do
  
  it "should validate presence of" do 
    # tests guid set to nil 
    adventure = Adventure.create(title: "Mr Tibs", author: "Spencer", guid: nil )
    adventure.should_not be_valid
  end

  it "should not validate short guid" do
    # tests a 9 character guid 
    adventure = Adventure.create(title: "Mr Tibs", author: "Spencer", guid: '9B78jliZ8' )
    adventure.should_not be_valid
  end

  it "should validate proper adventure" do
    # tests a 9 character guid 
    adventure = Adventure.create(title: "Mr Tibs", author: "Spencer", guid: '9B78jliZ8df' )
    adventure.should be_valid
  end

  it "should not validate no author" do
    # tests a 9 character guid 
    adventure = Adventure.create(title: "Mr Tibs", author: nil, guid: '9B78jliZ8df' )
    adventure.should_not be_valid
  end

  it "should not validate no title" do
    # tests a 9 character guid 
    adventure = Adventure.create(title: nil, author: "Spencer", guid: '9B78jliZ8df' )
    adventure.should_not be_valid
  end


end
