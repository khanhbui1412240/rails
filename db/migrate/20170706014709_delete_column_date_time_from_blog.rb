class DeleteColumnDateTimeFromBlog < ActiveRecord::Migration[5.1]
  def change
    remove_column :blogs, :datetime
  end
end
