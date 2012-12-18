require 'csv'
namespace :count_video_views do

  #report_folder = "lib/tasks/reports/"
  report_folder = "archived_reports/"

  desc "count the number of views of each video"
  task :count_views => :environment do
    date_range = ViewingStats.find_by_sql("SELECT to_char(min(start_date),'mm/dd/yy') AS start, to_char(max(start_date),'mm/dd/yy')  AS end FROM (SELECT start_date FROM viewing_stats WHERE start_date IS NOT NULL) AS starting_dates")
    total_views = ViewingStats.find_by_sql("SELECT COUNT(*) FROM viewing_stats WHERE video_name IS NOT NULL")
    results = ViewingStats.find_by_sql("SELECT video_name, COUNT(video_name),  " +
"sum(case when minutes_watched !=0 AND minutes_watched IS NOT NULL then 1  end) as watched_count,   " +
"sum(case when minutes_watched >= 7 AND minutes_watched IS NOT NULL then 1  end) as full_viewing,   " +
"sum(case when minutes_watched = 0 then 1  end) as not_viewed,  " +
"sum(case when minutes_watched IS NULL then 1  end) as unknown " +
"FROM viewing_stats WHERE  video_name IS NOT NULL AND  " +
"user_name != 'rlc' AND   video_name != '' " +
"GROUP BY video_name " +
"ORDER BY count DESC")

     filename =  make_filename date_range

     CSV.open(report_folder + filename, "w") do |csv|
       csv << ["Timeframe: " + date_range[0].start + " - " + date_range[0].end]
       csv << ["Total views: " + total_views[0].count]
       csv << ["Video", "Number of Views", "Viewed",  "Not Viewed", "Unknown", "Watched till end"]
       for r in results
       csv << [ r.video_name, r.count, r.watched_count, r.not_viewed, r.unknown, r.full_viewing ]
        end
     end
  end

  def make_filename date_range
    extension = "_view_counts.csv"
    start_date = date_range[0].start.gsub("/", "_")
    end_date = date_range[0].end.gsub("/", "_")
    name = start_date + "_to_" + end_date + extension
    return name
  end
end
