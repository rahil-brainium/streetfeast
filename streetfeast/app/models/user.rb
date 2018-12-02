class User < ActiveRecord::Base
  has_many :blogs
  has_many :support_tickets
  require "rubygems"
  require "net/https"
  require "uri"
  require "json"
  devise :invitable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :invitable,:omniauthable, omniauth_providers: [:google_oauth2]

    def self.from_omniauth(access_token)
	    data = access_token.info
	    user = User.where(email: data['email']).first
	    user
	  end

    def self.send_sms(number,message)
      requested_url = 'https://api.textlocal.in/send/?'     
      uri = URI.parse(requested_url) #hash
      http = Net::HTTP.start(uri.host, uri.port) #new connection TCP & http  
      request = Net::HTTP::Get.new(uri.request_uri) 
      res = Net::HTTP.post_form(uri, 'apikey' => 'mve1n+0ecp4-VQPne3KkGkXWJ7cR2zzoowr1evMcU1', 'message' => message, 'sender' => 'TXTLCL', 'numbers' => number)
    end
end
