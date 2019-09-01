FactoryBot.define do
  factory :labellings, class: Labelling do
    task_id { Task.first.id }
    label_id { Label.first.id }
  end
  factory :second_labellings, class: Labelling do
    task_id { Task.second.id }
    label_id { Label.second.id }
  end
  factory :third_labellings, class: Labelling do
    task_id { Task.third.id }
    label_id { Label.first.id }
  end
end
