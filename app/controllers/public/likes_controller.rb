class Public::LikesController < ApplicationController
  before_action :authenticate_member!
  def create
    @post = Post.find(params[:post_id])
    @like = current_member.likes.new(post_id: @post.id)
    @like.save
    # 通知の作成
    @post.create_notification_like!(current_member)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_member.likes.find_by(post_id: @post.id)
    like.destroy
  end
end
