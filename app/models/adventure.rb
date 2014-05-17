class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages

  before_save :add_guid

  validates :guid, uniqueness: true, length: { minimum: 10 }
  validates :title, presence: true
  validates :author, presence: true

  def add_guid
    self.guid ||= SecureRandom.urlsafe_base64(10)
  end

end
