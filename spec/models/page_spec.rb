require 'spec_helper'

describe Page do

  it "should not validate without name" do 
    page = Page.create(name: nil, text: "what an adventure")
    page.should_not be_valid
  end

  it "should not validate without text" do 
    page = Page.create(name: "start", text: nil)
    page.should_not be_valid
  end

  it "should be valid with a name and text" do 
    page = Page.create(name: 'start', text: 'what an adventure')
    page.should be_valid
  end
end
