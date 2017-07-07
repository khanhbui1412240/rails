class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :status
      t.datetime :datetime
      t.timestamps
    end
  end
end