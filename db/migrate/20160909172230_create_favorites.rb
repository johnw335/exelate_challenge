class CreateFavorites < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.belongs_to :user
      t.belongs_to :transportation

      t.timestamps
    end
  end
end
