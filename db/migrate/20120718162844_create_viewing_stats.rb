class CreateViewingStats < ActiveRecord::Migration
  def change
    create_table :viewing_stats do |t|
      t.string :user_name
      t.string :video_name
      t.string :video_id
      t.timestamp :start_date
      t.timestamp :end_date

      t.timestamps
    end
  end
end
