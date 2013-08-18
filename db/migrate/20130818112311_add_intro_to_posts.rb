class AddIntroToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :intro, :text
  end
end
