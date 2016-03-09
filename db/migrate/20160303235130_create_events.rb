class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :is_carpool
      t.boolean :is_meetup
      t.datetime :time
      t.string :location
      t.text :description
      t.references :concert, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
