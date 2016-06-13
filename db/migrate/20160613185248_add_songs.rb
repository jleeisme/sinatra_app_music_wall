class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :author
      t.string :url
      t.timestamps :created_at
      t.timestamps :updated_at
    end
  end
end
