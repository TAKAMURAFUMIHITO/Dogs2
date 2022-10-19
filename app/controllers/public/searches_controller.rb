class Public::SearchesController < ApplicationController
  before_action :authenticate_member!
  def search
    @range = params[:range]
    if @range == "会員"
      @members = Member.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
    @today = Date.today #今日の日付を取得
    @now = Time.now     #現在時刻を取得
  end
end
