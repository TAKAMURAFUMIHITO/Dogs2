class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).per(8)
    @today = Date.today # 今日の日付を取得
    @now = Time.now     # 現在時刻を取得
    @current_entry = Entry.where(member_id: current_member.id)  # ログインしてるユーザーとメッセージ相手のユーザー情報をEntryテーブルから検索して取得
    @another_entry = Entry.where(member_id: @member.id)
    unless @member.id == current_member.id                      # 会員がログインしていない時
      @current_entry.each do |current|                          # 取得した2つの会員情報をそれぞれeachで取り出してEntryテーブル内に同じroom_idが存在するか
        @another_entry.each do |another|
          if current.room_id == another.room_id                 # 同じroom_idが存在する場合 → 既にroomが存在している
            @is_room = true                                     # room_idの変数とroomが存在するかどうかの条件であるis_roomを渡す
            @room_id = current.room_id
          end
        end
      end
      unless @is_room                                           # 同じroom_idが存在しない場合は新しくインスタンスを作成
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def likes
    @member = Member.find(params[:id])
    likes = Like.where(member_id: @member.id).pluck(:post_id)
    @like_posts = Post.find(likes)
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
  end

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end
end
