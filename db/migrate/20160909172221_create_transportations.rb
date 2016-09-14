class CreateTransportations < ActiveRecord::Migration[5.0]
  def change
    create_table :transportations do |t|
      t.string :name
      t.string :transport_type
      t.timestamps
    end
  end
end
