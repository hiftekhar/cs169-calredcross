#require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'


class ProfileController < ApplicationController
  def index
    @user = current_user
    client_secrets = Google::APIClient::ClientSecrets.load
    auth_client = client_secrets.to_authorization
    auth_client.update!(
      :scope => 'https://www.googleapis.com/auth/calendar',
      :redirect_uri => 'http://www.example.com/oauth2callback'
    )
  end
end
