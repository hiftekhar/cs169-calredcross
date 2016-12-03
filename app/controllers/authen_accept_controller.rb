require 'google/api_client/client_secrets' 
#require 'googleauth'
#require 'google/apis/calendar_v2'

#require 'googleauth/stores/file_token_store'
#require 'google/apis/calendar_v3'

require 'fileutils'

class AuthenAcceptController < ApplicationController
  
  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def days_in_month(month, year = Time.now.year)
     return 29 if month == 2 && Date.gregorian_leap?(year)
     COMMON_YEAR_DAYS_IN_MONTH[month]
  end


def current_user
  return @current_user if defined?(@current_user)
  @current_user = User.new
end


  def accept
    
    @user = current_user
    
    
    if @user.refresh_token.nil? 
      print "go here"
      if params[:error]
        print "Error"
      else 
        print "**** auth ****"
        auth_code = params[:code] 
        client_secrets = Google::APIClient::ClientSecrets.load
        auth_client = client_secrets.to_authorization
        auth_client.update!(
          :scope => 'https://www.googleapis.com/auth/calendar',
          :redirect_uri => 'https://damp-forest-29318.herokuapp.com/authen_accept/accept',
          :access_type => 'offline'
        )
        auth_client.code = auth_code
        auth_client.fetch_access_token!
      end 
      @user.refresh_token = auth_client.refresh_token
      print "USER TOKEN"
      print "This is the refresh token"
      print @user.refresh_token
      print "USER TOKEN"
      @user.update_attribute(:refresh_token, auth_client.refresh_token)
    #  redirect_to root_path
 end 
    print "goes here"          
      signet = Signet::OAuth2::Client.new(
        client_id: "737968238189-n40p0c73pfbpr9ncmd67a4v84f7msuud.apps.googleusercontent.com",
        client_secret: "opY7uxs0lTAMjYzrm4e19NK4",
        token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
        refresh_token: @user.refresh_token
      )
      signet.refresh!
      
      # Use access token with picasa gem
      signet.access_token
          
      api_client = Google::APIClient.new
      cal = api_client.discovered_api('calendar', 'v3')
      
      
      curr_year = Time.now.strftime("%Y") 
      curr_month = Time.now.strftime("%m") 
    	
     
      list = api_client.execute(:api_method => cal.events.list, 
       	:authorization => signet,
       	:parameters => { 
    		'calendarId' => 'primary', 
       	  'singleEvents' => true 
       	})
    		 
    	
    
    puts "Fetched #{list.data.items.count} events..."
    
    # filter based on email and current month 
    
    # title, email, location
     
      hash_one = []
    
      i = 0
      while (i < list.data.items.count) do 
        # title, location, email, time, day  
        title = list.data.items[i].summary 
        print "title"
        print title

        
        if list.data.items[i].creator.nil? 
          email = ""
          location = ""
        else  
          email = list.data.items[i].creator.email  
         # print email
          location = list.data.items[i].location
        end  
        
        if list.data.items[i].start.dateTime.nil? 
          start_year = ""
          start_month = ""
          start_day = ""
          start_hour = ""
          start_minutes = ""
          start_am_or_pm = ""
        else   
          print "whoops 2"
          start_year = list.data.items[i].start.dateTime.strftime("%Y")  
          start_month = list.data.items[i].start.dateTime.strftime("%m")  
          start_day = list.data.items[i].start.dateTime.strftime("%d") 
          start_hour = list.data.items[i].start.dateTime.strftime("%I") 
          start_minutes = list.data.items[i].start.dateTime.strftime("%M") 
          start_am_or_pm = list.data.items[i].start.dateTime.strftime("%p") 
          print start_year
          print start_month
          #break 
        end 
        
        if list.data.items[i]["end"].nil? 
          end_year = ""
          end_month = ""
          end_day = ""
          end_hour = ""
          end_minutes = ""
          end_am_or_pm = ""
        else  
          
          print "whoops"
          end_year = list.data.items[i]["end"]["dateTime"].strftime("%Y")  
          end_month = list.data.items[i]["end"]["dateTime"].strftime("%m")  
          end_day = list.data.items[i]["end"]["dateTime"].strftime("%d") 
          end_hour = list.data.items[i]["end"]["dateTime"].strftime("%I") 
          end_minutes = list.data.items[i]["end"]["dateTime"].strftime("%M") 
          end_am_or_pm = list.data.items[i]["end"]["dateTime"].strftime("%p")
          print end_year 
          print "      "
          print end_month 
        end 
        
        # and start_year == curr_year and start_month == curr_month
        if title.include? "[CRC]" and start_year == curr_year and start_month == curr_month
          new_array = {"name" => title, "description" => list.data.items[i].description, "date" => list.data.items[i].start.dateTime, "location" => location} 
          print "hi"
          hash_one << new_array 
        end 
         
        i += 1
      end 
      
      params[:hash_one] = hash_one
      print "HAAASH ONE"
      print params[:hash_one]
      
      if params[:hash_one] == nil
        print "oops"
      end 
      
      
      redirect_to profile_index_path(:hash_one => hash_one)
       
    #  print "HASH"
    #  print hash_one.length
    #  print "HASH"
    

  end
end