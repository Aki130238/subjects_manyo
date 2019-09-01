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
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    FactoryBot.create(:third_label)
    FactoryBot.create(:task, user_id: user.id,)
    FactoryBot.create(:second_task, user_id: user.id)
    FactoryBot.create(:third_task, user_id: user.id)
    FactoryBot.create(:labellings)
    FactoryBot.create(:second_labellings)
    FactoryBot.create(:third_labellings)
  end
  
  scenario 'タスク一覧画面に遷移したら、作成済みのタスクが表示される' do
    # Task.create!(title: 'test_task_01', content: 'testtesttest', expiration_out: '2019-08-16 12:00:00', user_id: user.id)
    # Task.create!(title: 'test_task_02', content: 'samplesample', expiration_out: '2019-08-16 12:00:00', user_id: user.id)

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path
    # save_and_open_page

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    # expect(current_path).to have_content 'Factoryで作ったデフォルトのタイトル１'
    # expect(current_path).to have_content 'Factoryで作ったデフォルトのタイトル２'
    expect(page).to have_text /.*Factoryで作ったデフォルトのタイトル１.*Factoryで作ったデフォルトのタイトル２.*Factoryで作ったデフォルトのタイトル３.*/
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
    Task.create!(title: 'test_task_06', content: 'testtesttest06', id: user.id, expiration_out: '2019-08-16 12:00:00', user_id: user.id)
    visit task_path(id: user.id)
    expect(page).to have_content 'test_task_06'
    expect(page).to have_content 'testtesttest06'
  end
  
  scenario "タスク一覧のテスト" do
    visit tasks_path
  end
  
  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # タスクが作成日時の降順に並んでいるかのテスト
    # save_and_open_page この部分でViewを確認
    visit tasks_path
    expect(page).to have_text /.+タイトル２.+タイトル３.+/
  end

  scenario '終了期限順に並ぶこと' do
    Task.create!(title: '終了期限テスト2', content: 'shuryoukigenntitle2', expiration_out: '2019-08-15', user_id: user.id)
    Task.create!(title: '終了期限テスト1', content: 'shuryoukigenntitle1', expiration_out: DateTime.now, user_id: user.id)
    Task.create!(title: '終了期限テスト3', content: 'shuryoukigenntitle3', expiration_out: '2019-08-15', user_id: user.id)
    visit tasks_path
    click_link '終了期限でソート'
    
    expect(page).to have_text /.*終了期限テスト1.*終了期限テスト2.*終了期限テスト3.*/
    end

  scenario 'タイトル検索で任意の文字が含まれるタスクだけ表示される' do
    visit tasks_path
    fill_in 'title-search', with: 'タイトル２'
    #save_and_open_page
    click_button '絞り込み検索'
    expect(page).to_not have_text /.+タイトル３.+タイトル１.+/
  end

  scenario '優先順位でソートしたら高中低の順に並ぶ' do
    visit tasks_path
    click_link '優先順位でソート'
    expect(page).to have_text /.*タイトル２.*タイトル３.*タイトル１.*/
  end

  scenario 'ラベルをもつタスクをラベルで絞り込む' do
    visit tasks_path
    select "label1", from: 'label'
    click_button '絞り込み検索'
    expect(page).to have_text /.*タイトル１.*タイトル３.*/
  end

end
