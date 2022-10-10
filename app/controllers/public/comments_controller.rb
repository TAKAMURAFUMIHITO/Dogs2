class Public::CommentsController < ApplicationController
  before_action :authenticate_member!
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      #通知の作成
      @comment.post.create_notification_comment!(current_member, @comment.id)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
