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
    decrypted_email = URI.unescape(decrypted_string)

    assert_equal(email, decrypted_email)

  end
end
