class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :discount, :bio, :from_github
  has_many :books
  has_many :published
end
