require 'test_helper'

class ViewingStatsControllerTest < ActionController::TestCase

  def setup
    @start_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":43,"seconds":53,"tzOffset":240}'
    @end_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":48,"seconds":50,"tzOffset":240}'
    @restart_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":50,"seconds":50,"tzOffset":240}'
    @controller = ViewingStatsController.new
  end

  def test_start_play

    user_name = "fred"
    video_name = "once upon a time"
    video_id = "12345"
    start_date =  @start_date
    end_date = nil
    minutes_watched = 56.to_s
    id = nil
    tzoffset = 240

    params = get_test_params user_name, video_name, video_id, start_date, end_date, minutes_watched , id, tzoffset

    env = Rack::MockRequest.env_for("/",:params =>  params)

    endpoint = ViewingStatsController.action(:start_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    id = JSON.parse(body[2].body)[0]
    assert_not_nil(id)

    #Rack::MockRequest.new(start_play).post("start_play",:params =>params )

    stats = ViewingStats.find(id.to_i)
    assert_not_nil(stats)

    assert_equal(user_name, stats.user_name)
    assert_equal(video_name, stats.video_name)
    assert_equal(video_id, stats.video_id)
    assert_not_nil(stats.start_date)
    assert_equal(end_date, stats.end_date)
    assert_equal(id, stats.id)
  end

  def test_end_play

    user_name = "fred"
    video_name = "once upon a time"
    video_id = "12345"
    start_date =  @start_date
    end_date = nil
    minutes_watched = nil
    id = nil
    tzoffset = 240

    params = get_test_params user_name, video_name, video_id, start_date, end_date, minutes_watched , id, tzoffset

    env = Rack::MockRequest.env_for("/",:params =>  params)

    endpoint = ViewingStatsController.action(:start_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    id = JSON.parse(body[2].body)[0]
    assert_not_nil(id)

    stats = ViewingStats.find(id.to_i)
    assert_not_nil(stats)

    assert_equal(user_name, stats.user_name)
    assert_equal(video_name, stats.video_name)
    assert_equal(video_id, stats.video_id)
    check_some_date(stats.start_date)
    assert_nil(stats.end_date)
    assert_equal(minutes_watched, stats.minutes_watched)
    assert_equal(id, stats.id)

    end_date = @end_date
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => end_date })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    stats2 = ViewingStats.find(id.to_i)
    assert_not_nil(stats2.end_date)
    assert_equal(5, stats2.minutes_watched)

  end

  def test_end_play_no_date
    id = 1
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => nil })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)
    has_error = body[2].body_parts[0].include? ViewingStatsController::ERROR
    assert_equal(true, has_error)
  end

  def test_end_play_no_id
    id = ""
    end_date = @end_date
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => end_date })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)
    has_error = body[2].body_parts[0].include? ViewingStatsController::ERROR
    assert_equal(true, has_error)
  end

  def test_end_play_bad_id
    id = "10000"
    end_date = @end_date
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => end_date })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)
    has_error = body[2].body_parts[0].include? ViewingStatsController::ERROR
    assert_equal(true, has_error)
  end

  def test_restart_on_pause

    user_name = "fred"
    video_name = "once upon a time"
    video_id = "12345"
    start_date =  @start_date
    end_date = nil
    minutes_watched = nil
    id = nil
    tzoffset = 240

    params = get_test_params user_name, video_name, video_id, start_date, end_date, minutes_watched , id, tzoffset

    env = Rack::MockRequest.env_for("/",:params =>  params)

    endpoint = ViewingStatsController.action(:start_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    id = JSON.parse(body[2].body)[0]
    assert_not_nil(id)

    stats = ViewingStats.find(id.to_i)
    assert_not_nil(stats)

    assert_equal(user_name, stats.user_name)
    assert_equal(video_name, stats.video_name)
    assert_equal(video_id, stats.video_id)
    check_some_date(stats.start_date)
    assert_nil(stats.end_date)
    assert_equal(minutes_watched, stats.minutes_watched)
    assert_equal(id, stats.id)

    end_date = @end_date
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => end_date })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    stats2 = ViewingStats.find(id.to_i)
    assert_not_nil(stats2.end_date)
    assert_equal(5, stats2.minutes_watched)

    restart_date = @restart_date
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::STARTDATE_PARAM => restart_date })
    endpoint = ViewingStatsController.action(:restart_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    stats3 = ViewingStats.find(id.to_i)
    assert_not_nil(stats3.start_date)       # make this equal to restart_date
    assert_nil(stats3.end_date)
    assert_equal(5, stats3.minutes_watched)

    # put in  a new end_date and make sure that the minutes watched is correct
    end_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":52,"seconds":50,"tzOffset":240}'
    env = Rack::MockRequest.env_for("/",:params => {ViewingStatsController::ID_PARAM => id.to_s, ViewingStatsController::ENDDATE_PARAM => end_date })

    endpoint = ViewingStatsController.action(:end_play)
    body = endpoint.call(env)
    assert_not_nil(body)

    stats4 = ViewingStats.find(id.to_i)
    assert_not_nil(stats4.end_date)
    assert_equal(7, stats4.minutes_watched)

  end

  def test_get_params

    user_name = "fred"
    video_name = "once upon a time"
    video_id = "12345"
    start_date =  @start_date
    end_date = @start_date
    minutes_watched = 56
    id = nil
    tzoffset = 240

    params = get_test_params user_name, video_name, video_id, start_date, end_date, minutes_watched , id, tzoffset

    stats = @controller.get_params params

    assert_equal(user_name, stats.user_name)
    assert_equal(video_name, stats.video_name)
    assert_equal(video_id, stats.video_id)
    check_some_date(stats.start_date)
    check_some_date(stats.end_date)
    assert_equal(id, stats.id)
    assert_equal(tzoffset, stats.tz_offset)
  end


  def test_save_end_stats

    user_name = "fred"
    video_name = "once upon a time"
    video_id = "12345"
    start_date =  @start_date
    end_date = nil
    minutes_watched = nil
    id = nil
    tzoffset = 240

    params = get_test_params user_name, video_name, video_id, start_date, end_date, minutes_watched, id , tzoffset

    stats = @controller.get_params params
    assert_nil(stats.id)

    @controller.save_stats stats
    assert_not_nil(stats)
  end

  def test_elapsed_time
    stats =  ViewingStats.new
    stats.start_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":43,"seconds":53,"tzOffset":240}'
    stats.end_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":45,"seconds":53,"tzOffset":240}'

     elapsed_time = @controller.get_elapsed_time(stats.start_date, stats.end_date, nil)
     assert_not_nil(elapsed_time)
     assert_equal(2, elapsed_time)

     elapsed_time = @controller.get_elapsed_time(nil, stats.end_date, nil)
     assert_nil(elapsed_time)

     elapsed_time = @controller.get_elapsed_time(stats.start_date, nil, nil)
     assert_nil(elapsed_time)

    stats.start_date = '{"year":2012,"month":6,"day":23,"hours":23,"minutes":59,"seconds":53,"tzOffset":240}'
    stats.end_date = '{"year":2012,"month":6,"day":24,"hours":0,"minutes":3,"seconds":10,"tzOffset":240}'

    elapsed_time = @controller.get_elapsed_time(stats.start_date, stats.end_date, nil)
    assert_not_nil(elapsed_time)
    assert_equal(3, elapsed_time)

  end

  def test_elapsed_time_with_pause
    stats =  ViewingStats.new

    stats.start_date = '{"year":2012,"month":6,"day":23,"hours":23,"minutes":59,"seconds":53,"tzOffset":240}'
    stats.end_date = '{"year":2012,"month":6,"day":24,"hours":0,"minutes":3,"seconds":10,"tzOffset":240}'

    elapsed_time = @controller.get_elapsed_time(stats.start_date, stats.end_date, 4)
    assert_not_nil(elapsed_time)
    assert_equal(7, elapsed_time)

  end

  def test_elapsed_time_from_db

    stats =  ViewingStats.new
    stats.start_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":43,"seconds":53,"tzOffset":240}'
    stats.end_date = '{"year":2012,"month":6,"day":23,"hours":9,"minutes":45,"seconds":53,"tzOffset":240}'

    stats.save

    stats2 = ViewingStats.find(stats.id.to_i)
    elapsed_time = @controller.get_elapsed_time(stats2.start_date, stats2.end_date, nil)
    assert_not_nil(elapsed_time)
    assert_equal(2, elapsed_time)
  end

  # utility methods
  def get_test_params  username, videoname, videoid, startdate, enddate, minutes, id , tzoffset

    params = { ViewingStatsController::USERNAME_PARAM => username,
               ViewingStatsController::VIDEONAME_PARAM => videoname,
               ViewingStatsController::VIDEOID_PARAM => videoid,
               ViewingStatsController::STARTDATE_PARAM => startdate,
               ViewingStatsController::ENDDATE_PARAM => enddate,
              ViewingStatsController::MINUTESWATCHED_PARAM => minutes,
              ViewingStatsController::ID_PARAM => id,
               ViewingStatsController::TZOFFSET_PARAM => tzoffset ,
    }

    return params
  end

  def   test_parse_date
    date ='{"year":2012,"month":6,"day":23,"hours":9,"minutes":43,"seconds":53,"tzOffset":240}'
    stats =  ViewingStats.new

    stats.start_date = date
    assert_equal(2012, stats.start_date.year)
    assert_equal(6, stats.start_date.month)
    assert_equal(23, stats.start_date.day)
    assert_equal(9, stats.start_date.hour)
    assert_equal(43, stats.start_date.min)
    assert_equal(53, stats.start_date.sec)

    timeObj = Time.now
    stats.start_date = timeObj
    assert_equal(timeObj, stats.start_date)

    stats.end_date = timeObj
    assert_equal(timeObj, stats.end_date)

  end

  #utility methods
  def check_some_date  date
    assert_equal(2012, date.year)
    assert_equal(6, date.month)
    assert_equal(23, date.day)
    assert_equal(9, date.hour)
    assert_equal(43, date.min)
    assert_equal(53, date.sec)
  end

end