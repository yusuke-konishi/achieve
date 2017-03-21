class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.order("id").reverse_order
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end

  def edit
    # @blog = Blog.find(params[:id])
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
      # 一覧画面へ遷移して"ブログを更新しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      # 編集フォームを再描画します。
      render action: 'edit'
    end
  end

  def destroy
    # @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  private
    def blogs_params
      params.require(:blog).permit(:title, :content)
    end

    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end
end
