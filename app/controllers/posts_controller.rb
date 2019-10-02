# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[create new]
  def index
    @post = Post.paginate(page: params[:page])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = 'Micropost created!'
      redirect_to posts_path
    else
      render 'posts/new'
    end
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end
end
