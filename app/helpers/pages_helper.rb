module PagesHelper
  def linkify_page page
    regex = /\[\[([^|]+)\|(\w+)\]\]/
    page.text.gsub(regex) do |link|
      caps = regex.match(link)
      linked_page = page.adventure.pages.where(:name => caps[2]).first
      link_to(caps[1], adventure_page_path(page.adventure_id, linked_page.id))
    end
  end
end