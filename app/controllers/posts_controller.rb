class PostsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        render json: search_posts
      end
    end
  end

  def create
    post = Post.create!(post_params)
    render json: post
  end

  private

  def search_posts
    PostsSearch.search(params[:query], highlight: enable_highlight?)
  end

  def enable_highlight?
    params[:query].present?
  end

  def post_params
    params[:post].permit(:title, :body)
  end
end
