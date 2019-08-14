require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    # ここに内容を記載する
    task = Task.new(title: '失敗テスト2', content: '')
    expect(task).not_to be_valid

  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    # ここに内容を記載する
    task = Task.new(title: '成功テスト3', content: '成功テスト3')
    expect(task).to be_valid
  end

end