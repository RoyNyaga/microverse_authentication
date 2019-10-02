class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  def new
    @post = current_user.posts.build
  end

  def index
  end

  private
    def posts_params
      params.require(:post).permit(:content)
    end

end
