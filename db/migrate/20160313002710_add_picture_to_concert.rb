class AddPictureToConcert < ActiveRecord::Migration
  def change
    add_column :concerts, :image, :string
  end
end
