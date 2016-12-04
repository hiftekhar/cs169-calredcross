class HomeController < ApplicationController
  # For the sake of testing Heroku
  def index
    @images = Info.first.home_images.order(:id)

    if Info.all.empty?
      @info = Info.new
      @info.save
    else
      @info = Info.first
    end
    @date = Time.now.utc.strftime('%FT%TZ')
    @url = "https://www.googleapis.com/calendar/v3/calendars/americanredcrossatcal@gmail.com/events?key=AIzaSyAN3MLI-jD6mS6425sjj9QcBPWykxvsxZY&timeMin=" + @date
    
    require 'open-uri'
    buffer = open(@url).read
    response = JSON.parse(buffer)
    
    @events = response["items"]
  end
  
  
  def update
    @info = Info.first
    
    if params["bulletin"]
      print("~~~~~" + params["bulletin"].to_s)
      @info.update_bulletin(params["bulletin"])
    end
    
    if params["motm_name"]
      print("~~~~~" + params["motm_name"].to_s)
      @info.update_motm_name(params["motm_name"])
    end
    
    if params["motm_comments"]
      print("~~~~~" + params["motm_comments"].to_s)
      @info.update_motm_comments(params["motm_comments"])
    end
    
    if params[:info][:avatar]
      print("~~~~~~~~~~~~" + params[:info][:avatar].to_s + "~~~~~~~~~")
      @info.update_attribute(:avatar, params[:info][:avatar])
    end
  end

  def update_gallery
    id = params["photo_id"]
    url = params["url"]
    text = params["text"]
    home_image = HomeImage.find(id)
    if url != ""
      home_image.update_attribute(:url, url)
    end
    if text != ""
      home_image.update_attribute(:text, text)
    end
  end
end
