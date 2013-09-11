class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :intro, :body, :published, :updated_at
end
