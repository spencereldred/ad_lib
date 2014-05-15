require 'spec_helper'

describe PagesHelper do
  describe '#linkify_page' do
    before(:each) do
      @page = double("page")
      @adventure_id = 24358
      @page.stub(:adventure_id).and_return(@adventure_id)
      adventure = double("adventure")
      @adventure_pages = double("adventure's pages")
      linked_page = double("linked page")
      @linked_page_id = 9034509
      linked_page.stub(:id).and_return(@linked_page_id)
      @page.stub(:text).and_return{ "[[#{@display_text}|linktothis]]"}
      @page.stub(:adventure).and_return(adventure)
      adventure.stub(:pages).and_return(@adventure_pages)
      @adventure_pages.stub(:where).with(:name => "linktothis").and_return([linked_page])
    end
    it 'linkifies some text' do
      @display_text = "Display this"
      result = linkify_page(@page)
      result.should == "<a href=\"/adventures/#{@adventure_id}/pages/#{@linked_page_id}\">#{@display_text}</a>"
    end
    it 'escapes javascript' do
      @display_text = "</a> <script>alert('what now??')</script>"
      escaped_text = ERB::Util.html_escape(@display_text)
      result = linkify_page(@page)
      result.should == "<a href=\"/adventures/#{@adventure_id}/pages/#{@linked_page_id}\">#{escaped_text}</a>"
    end

    it 'linkifies multiple links' do 
      linked_pages = {"firstpage" => double(), "secondpage" => double()}
      @adventure_pages.stub(:where) {|opts| [linked_pages[opts[:name]]]}
      linked_pages["firstpage"].stub(:id).and_return(1)
      linked_pages["secondpage"].stub(:id).and_return(2)
      text = "[[first link|firstpage]] then some text [[second link|secondpage]]"
      @page.stub(:text).and_return(text)
      result = linkify_page(@page)
      result.should == "<a href=\"/adventures/#{@adventure_id}/pages/1\">first link</a> then some text <a href=\"/adventures/#{@adventure_id}/pages/2\">second link</a>"
    end
  end
end