class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    current_user_posts
    friends_post
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def current_user_posts
    @my_posts = current_user.posts
  end

  def friends_post
    @my_freinds_posts = current_user.posts_from_friends
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
