FactoryBot.define do
  factory :user, class: User do
    name { 'ユーザー１' }
    email { 'mail1@gmail.com' }
    password { 'password1' }
  end

  factory :second_user, class: User do
    name { 'ユーザー２' }
    email { 'mail2@gmail.com' }
    password { 'password2' }
  end

  factory :third_user, class: User do
    name { 'ユーザー３' }
    email { 'mail3@gmail.com' }
    password { 'password3' }
  end
end
