class AddAuthorToComments < ActiveRecord::Migration
  def change
    add_column :comments, :author, :text
  end
end
