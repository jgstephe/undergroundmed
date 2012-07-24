class AddMinutesColumn < ActiveRecord::Migration
  def up
    add_column :viewing_stats, :minutes_watched, :integer
  end

  def down
  end
end
