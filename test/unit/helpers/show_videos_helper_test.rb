# encoding: utf-8
require 'test_helper'

class ShowVideosHelperTest < ActionController::TestCase

  def setup
    @controller = ShowVideosController.new
    @radiology_ids = ["F8TYLT0-5fs", "DnBRarZKvoU", "z7_HseZBTT0", "8ZAN6vEuYjY", "4oYBLkbDjhg", "7tDDDLqWnBQ", "W_6v0v6tqCE", "oEmCcEio6nw", "4NNhGSXvbOU"]
  end

  test "test_init" do
    response = get :init
    assert_response :success
  end

  test "sort_by_order" do
    video1 = Video.new
    video1.order = 3
    video1.avg_rating = "video1"

    video2 = Video.new
    video2.order = 2
    video2.avg_rating = "video2"

    video3 = Video.new
    video3.order = 1
    video3.avg_rating = "video3"

    videolist =[video1, video2, video3]

    sorted_list = @controller.sort_by_order(videolist)
    assert_equal(1, sorted_list[0].order)
    assert_equal(2, sorted_list[1].order)
    assert_equal(3, sorted_list[2].order)
  end

  test "get_list_by_category"   do
    xml =  File.read("test/fixtures/videolist.xml");
    all_video_list = []
    ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_video_list))
    ShowVideosController.get_current_list

    assert_equal(25, all_video_list.length)

    video_list = ShowVideosHelper.get_list_by_category(VideoAttributes::RADIOLOGY, all_video_list)
    assert_equal(9, video_list.length)

    for video in video_list
      assert_equal(true, @radiology_ids.include?(video.yt_id))
    end

    video_list = ShowVideosHelper.get_list_by_category(VideoAttributes::ALL, all_video_list)
    assert_equal(25, video_list.length)
  end

  test "get_category_list"   do
    xml =  File.read("test/fixtures/videolist.xml");
    all_videos_list = []
     ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_videos_list))
     ShowVideosController.get_current_list

    assert_equal(25, all_videos_list.length)

    categories = @controller.get_category_list(all_videos_list)
    assert_equal(6, categories.length )
  end

  test "get_video_title"   do
    xml =  File.read("test/fixtures/videolist.xml");
    all_video_list = []
    ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_video_list))
    ShowVideosController.get_current_list

    assert_equal(25, all_video_list.length)
    featured_video_id="F8TYLT0-5fs"
    featured_video_title="Chest X-Ray Viewing Method - ABCDE"

    title = ShowVideosHelper.get_title(featured_video_id, all_video_list)
    assert_equal(featured_video_title, title)
  end

  test "get_title"   do
    xml =  File.read("test/fixtures/videolist.xml");
    all_video_list = []
    ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_video_list))
    ShowVideosController.get_current_list
    assert_equal(25, all_video_list.length)

    featured_video_title="Chest X-Ray Viewing Method - ABCDE"
    @controller.set_featured_id("F8TYLT0-5fs")

    title = @controller.get_featured_title(all_video_list);

    assert_equal(featured_video_title, title)
  end

  test "find_id" do
    xml =  File.read("test/fixtures/videolist.xml");
    all_video_list = []
    ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_video_list))
    ShowVideosController.get_current_list
    assert_equal(25, all_video_list.length)

    found = @controller.find_id("F8TYLT0-5fs", all_video_list)
    assert_equal(true, found)

    found = @controller.find_id("xyzzy-5fs", all_video_list)
    assert_equal(false, found)
  end

  test  "test_crypt"  do
    email = "rich.cohen@i-intime.org"
    encrypted_email =   "toen(einch#26o+ohrokc(ita"
    xor_key = 6

    decrypted_string = ShowVideosHelper.xor_decrypt(encrypted_email, xor_key)
    unencoded_email = URI.unescape(decrypted_string)

    assert_equal(email, unencoded_email)

    email_fr = "andré§@gmail.com"
    encoded_emal_fr = "andr%C3%A9%C2%A7%40gmail.com"
    encrypted_email_fr = "ghbt#E5#G?#E4#G1#26akgoj(eik"

    decrypted_string = ShowVideosHelper.xor_decrypt(encrypted_email_fr, xor_key)
    unencoded_email = URI.unescape(decrypted_string)
    assert_equal(email_fr, unencoded_email)

    email_de = "ßdussöäorf@gmail.com"
    encoded_emal_de = "%C3%9Fduss%C3%B6%C3%A4orf%40gmail.com"
    encrypted_email_de = "#E5#?@bsuu#E5#D0#E5#G2it`#26akgoj(eik"

    decrypted_string = ShowVideosHelper.xor_decrypt(encrypted_email_de, xor_key)
    unencoded_email = URI.unescape(decrypted_string)
    assert_equal(email_de, unencoded_email)

  end

  def test_get_all_videos
    video_list = @controller.get_all_videos
    assert_not_nil(video_list)
  end

  def test_update_id

    new_id = "ta9KNbcq-KI"
    settings = AppSettings.first
    assert_not_nil(settings)

    env = Rack::MockRequest.env_for("/",:params => {"id" => new_id })

    endpoint = ShowVideosController.action(:update_id)
    body = endpoint.call(env)

    settings = AppSettings.first
    assert_not_nil(settings)
    assert_equal(new_id, settings.featured_video_id)

  end

  def test_get_featured_video_id
    video_id = @controller.get_video_id_from_db

    assert_equal("az_PyTXFG9c", video_id)
  end

  def test_init_video_id

    env = Rack::MockRequest.env_for("/",:params => {"user" => "rlc" })

    endpoint = ShowVideosController.action(:init)
    body = endpoint.call(env)

    assert_not_nil(body)

  end

  def test_get_video_to_play

    video_id = "7w3F-U6j1yU"
    featured_video_id = "az_PyTXFG9c"
    params = {ShowVideosController::PLAYID_PARAM => video_id}
    all_videos = get_all_videos_list

    id_to_play = @controller.get_video_to_play(params, all_videos)
    assert_equal(true, id_to_play == video_id)

  end

  def test_get_video_to_play_returns_featured_video

    video_id = "7w3F-U6j1yU"
    featured_video_id = "az_PyTXFG9c"
    params = {"some_random_param" => video_id}
    all_videos = get_all_videos_list

    id_to_play = @controller.get_video_to_play(params, all_videos)
    assert_equal(true, id_to_play == featured_video_id)

  end

  def test_get_video_to_play_bad_id

    video_id = "7w3F-U6j1yU"
    featured_video_id = "az_PyTXFG9c"
    params = {ShowVideosController::PLAYID_PARAM => video_id}
    all_videos = get_all_videos_list

    id_to_play = @controller.get_video_to_play(params, all_videos)
    assert_equal(true, id_to_play == featured_video_id)

  end

  def test_get_video_to_play_bad_id

    video_id = "xyzzy"
    featured_video_id = "az_PyTXFG9c"
    params = {ShowVideosController::PLAYID_PARAM => video_id}
    all_videos = get_all_videos_list

    id_to_play = @controller.get_video_to_play(params, all_videos)
    assert_equal(true, id_to_play == featured_video_id)

  end


  def get_all_videos_list
    xml =  File.read("test/fixtures/videolist.xml");
    all_video_list = []
    ShowVideosController.stubs(:get_current_list).returns(YouTubeApiCallsHelper.parse_video_list(xml, all_video_list))
    ShowVideosController.get_current_list

    return all_video_list
  end
end
