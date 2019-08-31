FactoryBot.define do
  
     factory :label, class: Label do
        name { 'label1' }
      end
    #   factory :second_label, class: Label do
    #       name { 'label2' }
    #   end
    #   factory :third_label, class: Label do
    #       name { 'label3' }
    #   end
    end

#   factory :task do
#     title { 'Factoryで作ったデフォルトのタイトル１' }
#     content { 'Factoryで作ったデフォルトのコンテント１' }
#     status { '未着手' }
#     expiration_out { '2019-08-14 11:00:00' }
#     # user_id: { user.id }
#   end

#   # 作成するテストデータの名前を「second_task」とします
#   # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
#   factory :second_task, class: Task do
#       title { 'Factoryで作ったデフォルトのタイトル２' }
#       content { 'Factoryで作ったデフォルトのコンテント２' }
#       status { '着手中' }
#       expiration_out { '2019-08-14 12:00:00' }
#       # user_id: { user.id }
#   end

#   factory :third_task, class: Task do
#       title { 'Factoryで作ったデフォルトのタイトル３' }
#       content { 'Factoryで作ったデフォルトのコンテント３' }
#       status { '着手中' }
#       expiration_out { '2019-08-15 12:00:00' }
#       # user_id: { user.id }
#   end

# end
