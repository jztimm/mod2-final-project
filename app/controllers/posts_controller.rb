class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :like]

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    user = @post.user
    @post.destroy
    redirect_to user_path(user) #redirect to user show page
  end

  def like
    @post.increment!(:likes)

    redirect_to post_path(@post)
  end

  private
  
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description, :user_id)
  end

end