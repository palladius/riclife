#!/usr/bin/env ruby


# initiate authentication w/ gmail
  #
  # create url with url-encoded params to initiate connection with contacts api
  #
  # next - The URL of the page that Google should redirect the user to after authentication.
  # scope - Indicates that the application is requesting a token to access contacts feeds. 
  # secure - Indicates whether the client is requesting a secure token.
  # session - Indicates whether the token returned can be exchanged for a multi-use (session) token.
  #  
  next_param = "http%3A%2F%2Fwww.example.com%2F"
  scope_param = "http%3A%2F%2Fwww.google.com%2Fm8%2Ffeeds%2F"
  secure_param = "0"
  session_param = "1"
  root_url = "https://www.google.com/accounts/AuthSubRequest"
  query_string = "?scope=#{scope_param}&session=#{session_param}&secure=#{secure_param}&next=#{next_param}"
  #redirect_to root_url + query_string
  
  
  require 'net/http'
  require 'net/https'

    token = params[:token] # received the single-use authsub token, exchange for authsub session token

    http = Net::HTTP.new('www.google.com', 443)
    http.use_ssl = true
    path = '/accounts/AuthSubSessionToken'
    headers = {'Authorization' => "AuthSubtoken=\"#{token}\"" }
    resp, data = http.get(path, headers)

    if resp.code == "200" 
      token = ''
      data.split.each do |str|
        if not (str =~ /Token=/).nil?
          token = str.gsub(/Token=/, '')   
        end
      end
      redirect_to "http://www.example.com/?token=#{token}"
    else  
      redirect_to "http://www.example.com/"
    end