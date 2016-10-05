class ContactsController < ApplicationController
  # お問い合わせ一覧を @contacts に格納し、new.html.erb のデバッグ出力に渡す
  before_action :set_all

  def new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      # 入力フォームへ遷移して"お問い合わせありがとうございました！"とメッセージを表示します。
      #redirect_to new_contact_path, notice: "お問い合わせありがとうございました！"
      # トップページへ遷移して"お問い合わせが完了しました！"とメッセージを表示します。
      redirect_to root_path, notice: "お問い合わせが完了しました！"
      NoticeMailer.sendmail_contact(@contact).deliver
    else
      # 入力フォームを再描画します。
      render action: 'new'
    end
  end

  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end

  private
    def contacts_params
      params.require(:contact).permit(:name, :email, :content)
    end

    # お問い合わせ一覧を @contacts に格納する
    def set_all
      @contacts = Contact.all
    end
end
