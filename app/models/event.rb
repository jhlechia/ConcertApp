class Event < ActiveRecord::Base
  belongs_to :concert
  has_many :messages

  def get_lat
    @int_location = self.location.split(",")
    @lat = @int_location[0]
  end

  def get_lng
    @int_location = self.location.split(",")
    @lng = @int_location[1]
  end

end
