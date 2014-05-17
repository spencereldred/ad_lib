class Library < ActiveRecord::Base
  has_many :adventures

  validates :url, uniqueness: true, presence: true
end
