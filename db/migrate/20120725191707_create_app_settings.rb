class CreateAppSettings < ActiveRecord::Migration
  def change
    create_table :app_settings do |t|
      t.string :featured_video_id

      t.timestamps
    end
  end
end
