
require 'google/api_client/client_secrets' 
#require 'googleauth'
#require 'google/apis/drive_v2'

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
   
  #  client = Google::APIClient.new(
  #    application_name: 'Example Ruby application',
  #    application_version: '1.0.0'
  #  )
  
#   client.key = "737968238189-n40p0c73pfbpr9ncmd67a4v84f7msuud.apps.googleusercontent.com" 
#   Client.Authorization = auth_client.access_token

  #result = client.execute (
  #   Api_method : Client.Discovered_api ( : Plus ) .Activities.List,
  #   Parameters : { Collection : " Public " , userId : 101748015513264110691 }
  #)
  #service = Google::Apis::CalendarV3::CalendarService.new
  #  one = Google::API.new 
   
    #drive = Google::Apis::CalendarV2::CalendarService.new
     
end 


end
