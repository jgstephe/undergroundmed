require 'csv'
namespace :count_video_views do

  report_folder = "lib/tasks/reports/"

  desc "count the number of views of each video"
  task :count_views => :environment do
    date_range = ViewingStats.find_by_sql("SELECT to_char(min(start_date),'mm/dd/yy') AS start, to_char(max(start_date),'mm/dd/yy')  AS end FROM (SELECT start_date FROM viewing_stats WHERE start_date IS NOT NULL) AS starting_dates")
    total_views = ViewingStats.find_by_sql("SELECT COUNT(*) FROM viewing_stats WHERE video_name IS NOT NULL")
    results = ViewingStats.find_by_sql("SELECT video_name, COUNT(video_name),  " +
"sum(case when minutes_watched !=0 AND minutes_watched IS NOT NULL then 1  end) as watched_count,   " +
"sum(case when minutes_watched >= 7 AND minutes_watched IS NOT NULL then 1  end) as full_viewing,   " +
"sum(case when minutes_watched = 0 OR minutes_watched IS NULL then 1  end) as not_viewed,  " +
"sum(case when minutes_watched IS NULL then 1  end) as unknown " +
"FROM viewing_stats WHERE  video_name IS NOT NULL AND  " +
"user_name != 'rlc' AND   video_name != '' " +
"GROUP BY video_name " +
"ORDER BY count DESC")

     CSV.open(report_folder + "count_views.csv", "w") do |csv|
       csv << ["Timeframe: " + date_range[0].start + " - " + date_range[0].end]
       csv << ["Total views: " + total_views[0].count]
       csv << ["Video", "Number of Views", "Viewed", "Watched till end", "Not Viewed", "Unknown"]
       for r in results
       csv << [ r.video_name, r.count, r.watched_count, r.full_viewing, r.not_viewed, r.unknown ]
        end
     end
  end
end
