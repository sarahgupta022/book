class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title

      t.timestamps
    end
    add_index :albums, :user_id
  end
end
