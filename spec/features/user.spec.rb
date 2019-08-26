require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  background do
    FactoryBot.create(:user)
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

end
