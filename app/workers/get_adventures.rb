class GetAdventures
  
  include Sidekiq::Worker
  
  def perform
    libraries = Library.all
    libraries.each do |library|
      response = Typhoeus.get(library['url'] + "/adventures.json")
      adventures = JSON.parse(response.body)
      adventures['adventures'].each do |a|
        adventure = Adventure.create(title: a['title'], author: a['author'], guid: a['guid'], library_id: a['library_id'])
        a['pages'].each do |p|
          adventure.pages.create(name: p['name'], text: p['text'])
        end
      end
    end
  end

end