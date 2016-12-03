require 'google/api_client/client_secrets'

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
 
        
        @events = []
        
   
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