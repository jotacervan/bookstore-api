class AddGithubToAuthor < ActiveRecord::Migration[5.2]
  def change
    add_column :authors, :github_id, :integer
    add_column :authors, :from_github, :boolean, default: false
    add_column :authors, :bio, :text
  end
end
