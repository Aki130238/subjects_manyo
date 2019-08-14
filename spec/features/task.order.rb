require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  scenario "タスク一覧のテスト" do
    visit tasks_path
  end
  
  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # タスクが作成日時の降順に並んでいるかのテスト
    visit tasks_path
    expect(page).to have_text /.+タイトル２.+タイトル１.+/
  end
end