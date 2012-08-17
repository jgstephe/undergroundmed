class ViewingStatsController < ApplicationController

  USERNAME_PARAM = "username"
  VIDEONAME_PARAM = "videoname"
  VIDEOID_PARAM = "videoid"
  STARTDATE_PARAM =  "startdate"
  ENDDATE_PARAM = "enddate"
  MINUTESWATCHED_PARAM = "minutes"
  ID_PARAM = "id"
  TZOFFSET_PARAM = "tzoffset"

  ERROR = "fail"
  SUCCESS = "success"

  START_PLAY = "start_play"
  END_PLAY = "end_play"
  RESTART_PLAY = "restart_play"

  def start_play
  msg = ""

  begin
    stats  = get_params  params
    save_stats stats
    msg = [stats.id, START_PLAY]
  rescue   Exception => exception
    puts "---- Exception: viewing_stats/start_play " + exception.to_s
    msg = [ERROR]
  end

  render json: msg
  end

  def end_play
    msg  = ""

    begin
    id = params[ID_PARAM]
    end_date = params[ENDDATE_PARAM]

    if id == nil || id.length == 0
      raise "No id"
    end

    if end_date == nil || end_date.length == 0
      raise "No end date"
    end

    # if the id doesn't exist an exception will be raised
    stats = ViewingStats.find(id.to_i)

    stats.end_date = end_date

    elapsed_time = get_elapsed_time(stats.start_date, stats.end_date, stats.minutes_watched)
    stats.minutes_watched = elapsed_time

    stats.save
    msg = [id, END_PLAY]
    rescue   Exception => exception
      puts "---- Exception: viewing_stats/end_play " + exception.to_s
      msg = [ERROR]
    end

    render json:msg
  end

  # this is called when the video is restarted from being paused. We reset the start date, nil the end date
  # and keep the viewing minutes value.
  def restart_play
    msg  = ""

    begin
      id = params[ID_PARAM]
      restart_date = params[STARTDATE_PARAM]

      if id == nil || id.length == 0
        raise "No id"
      end

      if restart_date == nil || restart_date.length == 0
        raise "No restart date"
      end

      # if the id doesn't exist an exception will be raised
      stats = ViewingStats.find(id.to_i)

      stats.start_date = restart_date
      stats.end_date = nil

      stats.save
      msg = [id, RESTART_PLAY]
    rescue   Exception => exception
      puts "---- Exception: viewing_stats/restart_play " + exception.to_s
      msg = [ERROR]
    end

    render json:msg
  end

  def get_params   params_from_request
    stats = ViewingStats.new

    stats.user_name = params_from_request[USERNAME_PARAM]
    stats.video_name = params_from_request[VIDEONAME_PARAM]
    stats.video_id = params_from_request[VIDEOID_PARAM]
    stats.start_date = params_from_request[STARTDATE_PARAM]
    stats.end_date = params_from_request[ENDDATE_PARAM]
    stats.tz_offset = params_from_request[TZOFFSET_PARAM].to_i

    return stats
  end

  def save_stats stat
    stat.save
  end

  def get_elapsed_time start_time, end_time, minutes_watched
    elapsed_time = nil

    if start_time  == nil || end_time == nil
      return elapsed_time
    end

    if start_time.to_s.length  == 0 || end_time.to_s.length == 0
      return elapsed_time
    end

    #Time arithmetic returns seconds
    elapsed_time = (end_time - start_time )/60

    # this will be the case if the video was paused and then restarted
    if(minutes_watched != nil)
      elapsed_time += minutes_watched
    end

    return elapsed_time.round
  end

end
