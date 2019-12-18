class AddActiveToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :active, :boolean, default: true
  end
end
