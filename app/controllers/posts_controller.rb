class PostsController < ApplicationController
  def index
    @posts = PostSearch.search(params[:query])

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def create
    render :index
  end
end
