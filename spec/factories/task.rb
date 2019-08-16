FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
        title { 'Factoryで作ったデフォルトのタイトル１' }
        content { 'Factoryで作ったデフォルトのコンテント１' }
        expiration_out { '2019-08-14 11:00:00' }
    end

    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
        title { 'Factoryで作ったデフォルトのタイトル２' }
        content { 'Factoryで作ったデフォルトのコンテント２' }
        expiration_out { '2019-08-14 12:00:00' }
    end
end