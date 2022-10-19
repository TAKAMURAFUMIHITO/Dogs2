class Public::PostsController < ApplicationController
  before_action :authenticate_member!
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.member_id = current_member.id
    if post.save
      flash[:notice] = "投稿に成功しました。"
      redirect_to posts_path
    else
      @post = Post.new
      flash[:danger] = "投稿に失敗しました。入力内容を確認してから再度お試しください。"
      render "new"
    end
  end

  def index
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
    @posts = Post.all.page(params[:page]).per(15)
  end

  def show
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.member == current_member
      render :edit
    else
      redirect_to member_path(current_member)
    end
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      flash[:notice] = "投稿を編集しました。"
      redirect_to post_path(post.id)
    else
      @post = Post.find(params[:id])
      flash[:danger] = "編集に失敗しました。入力内容を確認してから再度お試しください。"
      render "edit"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  def likes
    @post = Post.find(params[:id])
    likes = Like.where(post_id: @post.id).pluck(:member_id)
    @like_members = Member.find(likes)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end
end
