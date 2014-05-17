require 'spec_helper'

describe Library do
  
  it "should not validate without url" do 
    library = Library.create(url: nil)
    library.should_not be_valid
  end

  it "should have a unique url" do 
    library1 = Library.create(url: '123.com')
    library2 = Library.create(url: '123.com')
    library2.should_not be_valid
  end

  it "should be valid with a url" do 
    library = Library.create(url: '123.com')
    library.should be_valid
  end

end
