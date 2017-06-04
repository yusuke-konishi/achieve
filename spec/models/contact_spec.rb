require 'rails_helper'

describe Contact do
  # 名前とメールアドレスと内容があれば有効な状態であること
  it "is valid with name, email and content" do
    contact = Contact.new(
      name: '織田 信長',
      email: 'nobunaga.oda@example.com',
      content: 'どうも、織田です。')
    expect(contact).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without name" do
    contact = Contact.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without email" do
    contact = Contact.new(email: nil)
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end

  # 内容がなければ無効な状態であること
  it "is invalid without content" do
    contact = Contact.new(content: nil)
    contact.valid?
    expect(contact.errors[:content]).to include("を入力してください")
  end
end
