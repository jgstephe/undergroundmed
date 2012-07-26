require 'csv'
namespace :count_video_views do

  report_folder = "lib/tasks/reports/"

  desc "count the number of views of each video"
  task :count_views => :environment do
    date_range = ViewingStats.find_by_sql("SELECT to_char(min(start_date),'mm/dd/yy') AS start, to_char(max(start_date),'mm/dd/yy')  AS end FROM (SELECT start_date FROM viewing_stats WHERE start_date IS NOT NULL) AS starting_dates")
    results = ViewingStats.find_by_sql("SELECT video_name, COUNT(video_name), ROUND(AVG(minutes_watched), 1) avg_watched FROM viewing_stats WHERE  video_name IS NOT NULL GROUP BY video_name ORDER BY count DESC ")
    total_views = ViewingStats.find_by_sql("SELECT COUNT(*) FROM viewing_stats WHERE video_name IS NOT NULL")

     CSV.open(report_folder + "count_views.csv", "w") do |csv|
       csv << ["Timeframe: " + date_range[0].start + " - " + date_range[0].end]
       csv << ["Total views: " + total_views[0].count]
       csv << ["Video", "Number of Views", "Avg. viewing time (minutes)"]
       for r in results
       csv << [ r.video_name, r.count, r.avg_watched ]
        end
     end
  end
end
