class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages
end
