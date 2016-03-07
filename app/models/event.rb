class Event < ActiveRecord::Base
  belongs_to :concert
  has_many :messages
end
