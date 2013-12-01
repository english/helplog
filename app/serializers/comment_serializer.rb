class CommentSerializer < ActiveModel::Serializer
  attributes :id, :post_id, :body, :author
end
