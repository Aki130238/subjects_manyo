require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  before do
    # ユーザー作成
    @user = (:user)
    # サインイン
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  background do
    FactoryBot.create(:second_user)
    FactoryBot.create(:third_user)
  end

  scenario 'ログインしたらshow画面へ遷移されること' do
    user = User.create!(name: 'テスト０', email: 'email0@gmail.com', password: 'aaaaaa')
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'user詳細画面'
  end

  scenario 'ログインユーザー以外のshow画面へ遷移できないこと' do
    user1 = User.create!(name: 'テスト０', email: 'email0@gmail.com', password: 'aaaaaa')
    user2 = User.create!(name: 'テスト１', email: 'email1@gmail.com', password: 'bbbbbb', id: '100')
    visit new_session_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: 'aaaaaa'
    click_button 'Log in'
    visit user_path(user2.id)
    #save_and_open_page
    # expect(page).to_not have_content 'user詳細画面'
    expect(current_path).not_to eq user_path(user2.id)
    expect(current_path).to eq tasks_path
  end

  scenario '管理画面のindex画面にユーザー一覧が表示されること' do
    user1 = User.create!(name: 'テスト０', email: 'email0@gmail.com', password: 'aaaaaa')
    user2 = User.create!(name: 'テスト１', email: 'email1@gmail.com', password: 'bbbbbb', id: '100')
    visit admin_users_path
    expect(page).to have_text /.*テスト０.*テスト１.*/
  end

  scenario '管理画面のnew画面からユーザー登録が成功すること' do
    visit new_admin_user_path
    fill_in '名前', with: 'コロッケ'
    fill_in 'メールアドレス', with: 'aaa@gmail.com'
    fill_in 'パスワード', with: 'aaaaaa'
    fill_in '確認用パスワード', with: 'aaaaaa'
    click_button 'Create my account'
    expect(page).to have_text /.*コロッケ\nEmail: aaa@gmail.com*/
  end

  scenario '管理画面のedit画面からユーザー編集が成功すること' do
    visit edit_admin_user_path(user.id)
    fill_in 'user_name', with: 'コロッケ'
    click_button 'Create my account'
    expect(page).to have_text /.*コロッケ.*/
  end
end
