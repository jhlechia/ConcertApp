class Event < ActiveRecord::Base
  belongs_to :concert
  has_many :messages
  validates :concert_id, presence: true
end
