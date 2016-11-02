
require 'google/api_client/client_secrets' 
#require 'googleauth'
#require 'google/apis/calendar_v2'

#require 'googleauth/stores/file_token_store'
#require 'google/apis/calendar_v3'

require 'fileutils'

class AuthenAcceptController < ApplicationController
  def accept
    if params[:error] 
      # do something
    else 
      auth_code = params[:code] # save thsi one to database, so they only have to authenticate once 
      client_secrets = Google::APIClient::ClientSecrets.load
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        :scope => 'https://www.googleapis.com/auth/calendar',
        :redirect_uri => 'http://hiftekhar-hiftekhar.c9users.io:8080/authen_accept/accept'
      )
      auth_client.code = auth_code
      auth_client.fetch_access_token!
    end 
    
    
    
    
    session[:access_token] = response['access_token']
    
    client = Signet::OAuth2::Client.new(access_token: session[:access_token])
    
    
  api_client = Google::APIClient.new
  cal = api_client.discovered_api('calendar', 'v3')
    
   # service = Google::APIClient::CalendarV3::CalendarService.new
   
   
puts "Getting list of events..."
list = api_client.execute(:api_method => cal.events.list, 
	:authorization => auth_client,
	:parameters => {
		'maxResults' => 20, 
		'q' => 'Meeting', 
		'calendarId' => 'primary'})

puts "Fetched #{list.data.items.count} events..."

#puts "Updating first event from list..."
#update_event = list.data.items[0]
#update_event.description = "Updated Description here"
#result = api_client.execute(:api_method => cal.events.update, #
#	:authorization => auth_client,#
#	:parameters => { 'calendarId' => 'primary', 'eventId' => update_event.id}, 
#	:headers => {'Content-Type' => 'application/json'},#
#	:body_object => update_event)
#puts "Done with update."
     
#end 

  i = 0
  while (i < list.data.items.count) do 
    print list.data.items[i].description
    i += 1
  end 
  
end 


end
