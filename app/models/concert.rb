class Concert < ActiveRecord::Base
  belongs_to :user
  has_many :events
  validates :artist, :venue, :date, presence: true
end
