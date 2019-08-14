require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  
  scenario 'タスク一覧画面に遷移したら、作成済みのタスクが表示される' do
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario 'タスク登録画面で、必要項目を入力してcreateボタンを押したらデータが保存される' do
    visit new_task_path
    fill_in 'タイトル', with: 'test_task_05'
    fill_in '内容', with: 'testtesttest05'
    click_button '登録する'
    task = Task.last
    visit task_path(task.id)
    #visit tasks_path
    expect(page).to have_content 'test_task_05'
    expect(page).to have_content 'testtesttest05'
  end

  scenario '任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移する' do
    Task.create!(title: 'test_task_06', content: 'testtesttest06', id: '6')
    task = Task.new(title: 'test_task_06', content: 'testtesttest06', id: '6')
    visit task_path(id: '6')
    expect(page).to have_content 'test_task_06'
    expect(page).to have_content 'testtesttest06'
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