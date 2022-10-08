class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
  end

  def edit
    @member = Member.find(params[:id])
    if @member == current_member
      render :edit
    else
      redirect_to member_path(current_member)
    end
  end

  def update
    member = Member.find(params[:id])
    if member.update(member_params)
      redirect_to member_path(current_member)
    else
      render "edit"
    end
  end

  def confirm
  end

  def withdraw
    @member = Member.find(params[:id])
    @member.update(is_deleted: true)    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    reset_session
    flash[:withdraw] = "退会処理を実行いたしました"
    redirect_to new_member_registration_path
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end
end
