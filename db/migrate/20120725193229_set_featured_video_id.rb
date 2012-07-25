class SetFeaturedVideoId < ActiveRecord::Migration
  def up
   AppSettings.create :featured_video_id => "F8TYLT0-5fs"
  end

  def down
  end
end
