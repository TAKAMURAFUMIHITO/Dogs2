class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :post_id
      t.integer :visitor_id, foreign_key: { to_table: :members }
      t.integer :visited_id, foreign_key: { to_table: :members }
      t.integer :comment_id
      t.integer :room_id
      t.integer :message_id
      t.string  :action
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
