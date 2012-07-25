require 'you_tube_api_calls_helper'
require 'uri'

class ShowVideosController < ApplicationController

  $featured_video_id= ""
  $featured_video_title=""
  $xor_key = 6
  $user = "unknown"

  SESSION_KEY_ALL_VIDEOS = "all_videos"
  def init
    video_list = get_current_list
    @category_list =  get_category_list(video_list)
    $featured_video_id = get_video_id_from_db
    $featured_video_title =  get_featured_title (video_list)
    RunTimeEnvironment.log_runtime_environment()
    $user = get_user params
  end

  def get_category_list  (video_list)
    categories =[ "All" ]

    for video in video_list
      if !categories.include?(video.category)
         categories.push(video.category)
      end
    end

    return sort_by_category(categories)
  end

  def get_list
    category = params[:category]

    @video_list = get_current_list
    @video_list = ShowVideosHelper.get_list_by_category(category, @video_list)
    @video_list = sort_by_order(@video_list)
    #session[SESSION_KEY_ALL_VIDEOS] = @video_list

    render json: @video_list
  end

  def get_current_list
    if(session[SESSION_KEY_ALL_VIDEOS] == nil)
      video_list = get_all_videos
    else
      video_list = session[SESSION_KEY_ALL_VIDEOS]
    end

    return  video_list
  end

=begin
  get_all_videos pages through the YouTube results list. Two factors control paging, YouTubeApiCallsHelper::MAXRESULTS
  which limits the results returned in a query (the max YouTube will return is 50)  and the total results the query generated
  which is in the <openSearch:totalResults> tag.

  The YouTube documentation cautions the the <openSearch:totalResults> may not be accurate because the results of a query which
  returns a large result set can vary as the YouTube site changes. In our case the result set is small so the risk is low using this tag.
=end
  def get_all_videos
    # get the first set of results
    video_list = []
    start_index = 1
    response =   YouTubeApiCallsHelper.get_video_list(start_index)
    YouTubeApiCallsHelper.parse_video_list(response.body, video_list)
    total_results = YouTubeApiCallsHelper.get_total_results(response.body)

    if video_list.length  < total_results
      start_index +=  YouTubeApiCallsHelper::MAXRESULTS

      # if there are more results to fetch, loop till we have them all
      while video_list.length  < total_results
        response =   YouTubeApiCallsHelper.get_video_list(start_index)
        count = YouTubeApiCallsHelper.parse_video_list(response.body, video_list)
        start_index += count

        # we have seen instances in testing where it appears that there are more results
        # but when the results are parsed nothing is returned (count == 0). This could result
        # in an infinite loop so we add the check for count == 0.
        if start_index >= total_results  || count == 0
            break
        end

        end
      end

      return video_list
  end

  def save_contact
    makeVideo = params[:video]
    reviewVideo = params[:review]
    comments = URI.unescape(params[:comments])

    decrypted_name =  ShowVideosHelper.xor_decrypt(params[:name], $xor_key)
    name = URI.unescape(decrypted_name)

    decrypted_email = ShowVideosHelper.xor_decrypt(params[:email], $xor_key)
    email = URI.unescape(decrypted_email)
    add_to_list = params[:addToList]

    contact_detail = ContactDetail.new(makeVideo, reviewVideo, add_to_list, comments, name, email)
    save_contact_detail (contact_detail)

    msg =["Your selections have been saved. Thanks."]   #json generate wants a data structure, not a string

    render json: msg

  end

  def sort_by_order(videolist)
    sorted_list = videolist.sort { |a,b| a.order.to_i <=> b.order.to_i }
    return sorted_list
  end

  def sort_by_category(category_list)
    sorted_list = category_list.sort { |a,b| a <=> b }
    return sorted_list
  end

  def save_contact_detail (contact_detail)

      MailContactDetail.send_detail(contact_detail).deliver

  end

  def update_id

    newId = params[:id]

    if newId != nil && newId.length > 0
      video_list = get_current_list

      if find_id(newId, video_list)
          set_featured_id(newId)
          $featured_video_title = get_featured_title(video_list)

          settings = AppSettings.first
          settings.featured_video_id = newId
          settings.save
      else
        puts "update_id: unknown id: " + newId
      end

    else
      puts "update_id: no id specified"
    end

    site = get_redirect_site()

    redirect_to  site
  end

  def get_redirect_site
    site = "http://strong-meadow-4887.herokuapp.com/"
    if RunTimeEnvironment.is_development?
      site = "http://localhost:3000/"
    end
    site
  end

  def get_featured_title (video_list)
    return  ShowVideosHelper.get_title($featured_video_id, video_list)
  end

  def set_featured_id (id)
    $featured_video_id = id
  end

  def find_id (id, video_list)
    found = ShowVideosHelper.find_id(id, video_list)
  end

   def get_user params
     user = params[:user]

     if user == nil || user.length == 0
       user = "unknown"
     end

     return user
   end

  def get_video_id_from_db
    settings = AppSettings.first

    return settings.featured_video_id
  end

end
