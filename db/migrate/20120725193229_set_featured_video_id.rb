class SetFeaturedVideoId < ActiveRecord::Migration
  def up
   AppSettings.create :featured_video_id => "az_PyTXFG9c"
  end

  def down
  end
end
