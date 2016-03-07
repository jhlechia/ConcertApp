class Message < ActiveRecord::Base
  belongs_to :event
  validates :body, :event_id, presence: true
end
