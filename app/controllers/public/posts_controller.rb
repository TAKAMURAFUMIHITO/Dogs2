class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.member_id = current_member.id
    if post.save
      redirect_to posts_path
    else
      @posts = Post.all
      render 'new'
    end
  end

  def index
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
    @posts = Post.all
  end

  def show
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to post_path(post.id), notice: "投稿を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end
end
