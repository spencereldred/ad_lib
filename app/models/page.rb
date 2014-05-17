class Page < ActiveRecord::Base
  belongs_to :adventure

  validates :name, presence: true
  validates :text, presence: true

end
