class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
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
  end

  def update
     member = Member.find(params[:id])
    if member.update(member_params)
      redirect_to admin_members_path
    else
      render "edit"
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end
end
