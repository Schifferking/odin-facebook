class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @friends = Relationship.friends(current_user.id).append(current_user.id)
    @posts = Post.friend_posts(@friends)
  end

  def show
    @post = Post.find(params[:id])
    @like = Like.new
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
