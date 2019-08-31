RSpec.feature "管理者機能", type: :feature do
  background do
    FactoryBot.create(:label_user)
    FactoryBot.create(:second_label_user)
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    FactoryBot.create(:label_task)
    FactoryBot.create(:label2_task)
    FactoryBot.create(:label_second_task)
    FactoryBot.create(:label2_second_task)
    FactoryBot.create(:labelling)
    FactoryBot.create(:second_labelling)
    FactoryBot.create(:labelling_second_user)
    FactoryBot.create(:second_labelling_second_user)
  end
  before do
    visit new_session_path
    fill_in 'session_email', with: 'label1@test.com'
    fill_in 'session_password', with: 'aaaaaa'
    click_on 'ログインする'
  end
  scenario "ラベルユーザー１一覧のテスト" do
    # ラベルユーザー１のタスクをラベル１だけ表示
    visit tasks_path
    select 'ラベル１', from: 'label_id'
    find("#label_search").click
    save_and_open_page
    expect(page).to have_content 'ラベル１ユーザー１'
  end
 end
 # bin/rspec spec/features/label.spec.rb