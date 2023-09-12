class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :member_id, null: false
      t.integer :post_id
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.integer :select_post

      t.timestamps
    end
  end
end
