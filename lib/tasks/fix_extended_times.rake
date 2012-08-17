namespace :fix_times do

  desc "Fixes cases where we were not handling pause state correctly. We set these records to 0 since we don't know what the actual time would be"
  task :fix_times => :environment do
    results = ViewingStats.find_by_sql("SELECT * FROM viewing_stats WHERE minutes_watched > 8")

    puts "results count: " + results.length.to_s

    for r in results
      puts  r.video_name + ":  " + r.minutes_watched.to_s
     r.minutes_watched  = 0
     r.save
    end
  end
end