require 'csv'
namespace :count_domains do

  report_folder = "lib/tasks/reports/"

  desc "count domains of users who viewed videos"
  task :count_domains => :environment do
    date_range = ViewingStats.find_by_sql("SELECT to_char(min(start_date),'mm/dd/yy') AS start, to_char(max(start_date),'mm/dd/yy')  AS end FROM (SELECT start_date FROM viewing_stats WHERE start_date IS NOT NULL) AS starting_dates")
    results = ViewingStats.find_by_sql("SELECT substring(user_name from position('@' in user_name)+1) AS domain, COUNT(user_name) FROM viewing_stats " +
                                                                          "WHERE user_name != 'unknown' AND user_name IS NOT NULL AND position('@' in user_name) != 0  " +
                                                                          "GROUP BY domain  " +
                                                                          "ORDER BY count DESC")

    CSV.open(report_folder + "count_domains.csv", "w") do |csv|
      csv << ["Timeframe: " + date_range[0].start + " - " + date_range[0].end]
      csv << ["Domain ", "Count"]
      for r in results
        csv << [ r.domain, r.count ]
      end
    end
  end
end