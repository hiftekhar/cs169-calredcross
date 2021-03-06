require 'google/api_client/client_secrets'
require 'date'
class ProfileController < ApplicationController

  def index
    
    
    @user = current_user
    # @images = ["lilbub1.jpeg", "lilbub2.jpg", "lilbub4.jpg"]
    @images = current_user.photos
    @events = Event.all.last(3)
    if current_user.level == "gold"
      @level = "gold_status.png"
    # elsif current_user.level == "bronze"
    else
      @level = "bronze_medal.png"
    end
    @date = Time.now.utc.strftime('%FT%TZ')
    @url = "https://www.googleapis.com/calendar/v3/calendars/americanredcrossatcal@gmail.com/events?key=AIzaSyAN3MLI-jD6mS6425sjj9QcBPWykxvsxZY&timeMin=" + @date 
    
    require 'open-uri'
    buffer = open(@url).read
    response = JSON.parse(buffer)
    
    @events = response["items"]
    @events = @events.sort { |x,y| 
      date1 = x["start"]["date"] || x["start"]["dateTime"]
      date2 = y["start"]["date"] || y["start"]["dateTime"]
      date1 = date1.to_time
      date2 = date2.to_time
      if date1 < date2
        -1
      elsif date1 > date2
        1
      else 
        0
      end
    } 
    # @today = Time.now.strftime("%Y-%m-%d")
    @today = Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%Y-%m-%d")
    print("~~~~~~~~~~" + @today)
    @events.each do |event|
      print(event.to_s + "\n")
    end
   
        
   
  end
  
  #hi
  
  def events_one 
    print "Hi"
    
    if params[:hash_one].nil? 
      print "haaaai"
    else 
      print "boba"
    end  
    
  end 

  def getUser 
    @user = User.find(params["id"])
    # @images = ["lilbub1.jpeg", "lilbub2.jpg", "lilbub4.jpg"]
    @images = @user.photos
    @events = Event.all.last(3)
    if @user.level == "gold"
      @level = "gold_status.png"
    else
      @level = "bronze_medal.png"
    end
    @date = Time.now.utc.strftime('%FT%TZ')
    @url = "https://www.googleapis.com/calendar/v3/calendars/americanredcrossatcal@gmail.com/events?key=AIzaSyAN3MLI-jD6mS6425sjj9QcBPWykxvsxZY&timeMin=" + @date 
    
    require 'open-uri'
    buffer = open(@url).read
    response = JSON.parse(buffer)
    
    @events = response["items"]
    @events = @events.sort { |x,y| 
      date1 = x["start"]["date"] || x["start"]["dateTime"]
      date2 = y["start"]["date"] || y["start"]["dateTime"]
      date1 = date1.to_time
      date2 = date2.to_time
      if date1 < date2
        -1
      elsif date1 > date2
        1
      else 
        0
      end
    } 
    @today = Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%Y-%m-%d")
    render "index"
  end

  def update
    @user = current_user 
    
    if params["name"]
      print("~~~~~" + params["name"].to_s)
      @user.editName(params["name"])
    end
    if params["details"]
      print("~~~~~" + params["details"].to_s)
      @user.editDescription(params["details"])
    end
    if params[:user][:avatar]
      print("~~~~~" + params[:user][:avatar].to_s)
      @user.update_attribute(:avatar, params[:user][:avatar])
    end
  end
  
  
end