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
      
      if params[:hash_one] != nil 
        i = 0 
        print "what's going on"
        
        @one = [] 
        
        @events = []
        @events_list = params[:hash_one]
        
        while i < @events_list.length 
          name = @events_list[i]["name"]
          date = @events_list[i]["date"]
          location = @events_list[i]["location"]
          description = @events_list[i]["description"]
          print "NAME ", name
          print "DATE ", date     
          print "LOCATION ", location 
          print "DATE ", date
          
          #comment
          
          @event_one = Event.new
          @event_one.editName(name) 
          @event_one.editLocation( location)
          @event_one.editDescription(description)
          @event_one.editDate(date)
          
          i = i+1
          
          @events << @event_one 
          
        end 
         
        
      else  
 
         if @user.refresh_token.nil? 
          # need to authorize faaaam 
          print "goes here 33"
          client_secrets = Google::APIClient::ClientSecrets.load
          auth_client = client_secrets.to_authorization
          auth_client.update!(
          :scope => 'https://www.googleapis.com/auth/calendar',
          :redirect_uri => 'https://damp-forest-29318.herokuapp.com/authen_accept/accept',
          :access_type => 'offline'
          )
          redirect_to auth_client.authorization_uri.to_s
        else
          
          @events = []
          
          #redirect_to '/authen_accept/accept'
        end  
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