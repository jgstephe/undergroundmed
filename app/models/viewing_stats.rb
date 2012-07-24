class ViewingStats < ActiveRecord::Base
  attr_accessible :end_date, :start_date, :user_name, :video_id, :video_name, :minutes_watched, :tz_offset

  def parse_date date
    if date == nil || date.length == 0
      return nil
    end

    parsed_date = JSON.parse(date)

    # assumption is that the date thats passed is utc
    new_date =  Time.utc(parsed_date["year"], parsed_date["month"], parsed_date["day"], parsed_date["hours"], parsed_date["minutes"],
                         parsed_date["seconds"])

    return new_date
  end

  # overridding default accessors. Can either be a json string or Time object
  def start_date=(date)
     parsed_date = get_parsed_date(date)
    write_attribute(:start_date, parsed_date)
  end

  def end_date=(date)
    parsed_date = get_parsed_date(date)
    write_attribute(:end_date, parsed_date)
  end

  def get_parsed_date(date)
    if date.class.name != "Time"
      parsed_date = parse_date (date)
    else
      parsed_date = date
    end
    parsed_date
  end

end
