class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :highlights

  def highlights
    object.highlights if object.respond_to?(:highlights)
  end
end
