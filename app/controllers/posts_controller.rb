class PostsController < ApplicationController
  def index
    @posts = PostsSearch.search(params[:query], highlight: params[:query].presence)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def create
    post = Post.create!(post_params)
    render json: post
  end

  private

  def post_params
    params[:post].permit(:title, :body)
  end
end
