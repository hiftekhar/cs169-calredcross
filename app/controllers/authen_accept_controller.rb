
require 'google/api_client/client_secrets' 
#require 'googleauth'
#require 'google/apis/calendar_v2'

#require 'googleauth/stores/file_token_store'
#require 'google/apis/calendar_v3'

require 'fileutils'

class AuthenAcceptController < ApplicationController
  def accept
 #   if params[:error] 
#      # do something
#    else 
#      print "**** auth ****"
#      auth_code = params[:code] # save thsi one to database, so they only have to authenticate once
#      print
#      client_secrets = Google::APIClient::ClientSecrets.load
#      auth_client = client_secrets.to_authorization
#      auth_client.update!(
#        :scope => 'https://www.googleapis.com/auth/calendar',
#        :redirect_uri => 'http://hiftekhar-hiftekhar.c9users.io:8080/authen_accept/accept',
#        :access_type => 'offline'
 #     )
#      auth_client.code = auth_code
#      auth_client.fetch_access_token!
#    end 
    
#    print "***"
#    print auth_client.code
#    print auth_client.refresh_token
#    print "****"

signet = Signet::OAuth2::Client.new(
  client_id: "737968238189-n40p0c73pfbpr9ncmd67a4v84f7msuud.apps.googleusercontent.com",
  client_secret: "opY7uxs0lTAMjYzrm4e19NK4",
  token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
  refresh_token: "1/2wOMMrYwCf3cZGfMT-W3k7Bmrq5jzMHBN_VQ0DVnQjg"
)
signet.refresh!

# Use access token with picasa gem
signet.access_token
    
     api_client = Google::APIClient.new
  cal = api_client.discovered_api('calendar', 'v3')
    
   # service = Google::APIClient::CalendarV3::CalendarService.new
   
   
puts "Getting list of events..."
list = api_client.execute(:api_method => cal.events.list, 
	:authorization => signet,
	:parameters => {
		'maxResults' => 20, 
		'q' => 'Meeting', 
		'calendarId' => 'primary'})

puts "Fetched #{list.data.items.count} events..."

  i = 0
  while (i < list.data.items.count) do 
    print list.data.items[i].description
    i += 1
  end 
    
  
end 


end