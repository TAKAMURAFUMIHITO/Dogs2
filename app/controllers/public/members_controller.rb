class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update]
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
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
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to member_path(@member.id), notice: "プロフィールを更新しました。"
    else
      render "edit"
    end
  end

  def confirm
  end

  def withdraw
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @menber == current_member
      redirect_to member_path(current_member)
    end
  end
end
