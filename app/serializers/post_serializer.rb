class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :intro, :body, :published
end
