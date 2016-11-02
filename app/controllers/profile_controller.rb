#require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'


class ProfileController < ApplicationController
  def index
    @user = current_user
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/calendar',
      :redirect_uri => 'http://hiftekhar-hiftekhar.c9users.io:8080/authen_accept/accept'
    )
    redirect_to auth_client.authorization_uri.to_s
  end
end
