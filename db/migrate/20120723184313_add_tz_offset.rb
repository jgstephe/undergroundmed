class AddTzOffset < ActiveRecord::Migration
  def up
    add_column :viewing_stats, :tz_offset, :integer
  end

  def down
  end
end
