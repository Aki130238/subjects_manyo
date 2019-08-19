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
  
  it "タイトルのみで検索されたらタイトル検索のみで結果を返す" do
    task1 = Task.create!(title: '終了期限テスト2', content: 'shuryoukigenntitle2', status: '未着手', expiration_out: '2019-08-15')
    task2 = Task.create!(title: 'テスト1', content: 'shuryoukigenntitle1', status: '着手中', expiration_out: DateTime.now)
    task3 = Task.create!(title: '終了期限テスト3', content: 'shuryoukigenntitle3', status: '完了', expiration_out: '2019-08-14')
    task = Task.wheretitle("テスト1")
    # expect(task).to have_text /.+終了期限テスト1.+/
    expect(task[0]).to eq task2
  end

end
