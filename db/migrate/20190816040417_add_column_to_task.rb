class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :expiration_out, :datetime, default: DateTime.now
  end
end
