class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages

  before_save :add_guid

  validates :guid, presence: true, length: { minimum: 10 }

  def add_guid
    self.guid ||= SecureRandom.urlsafe_base64(10)
  end

end
