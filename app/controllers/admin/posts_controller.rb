class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
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

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
end
