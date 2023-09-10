class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :member_id
      t.integer :post_id
      t.string :title
      t.datetime :start_time

      t.timestamps
    end
  end
end
