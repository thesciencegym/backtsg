require 'net/http'
require 'uri'
class User < ApplicationRecord
  validates :email, uniqueness: true
  has_many :orders

  def self.get_VG_users
    @url = 'https://api.virtuagym.com/api/v1/club/25396/member'
    sync = User.last.timestamp_edit
    response = get(@url, sync)
    @users = response['result']
    @users.each do |user|
      unless User.exists?(email: user['email'])
        new_user = User.create!(first_name: user['firstname'], last_name: user['lastname'],
                            email: user['email'], member_id: user['member_id'],
                            mobile: user['mobile'], vg_user_id: user['user_id'],
                            gender: user['gender'], city: user['place'],
                            timestamp_edit: user['timestamp_edit'])
        p "user #{new_user.email} is found or created"
      end
    end
  end

  def self.get(url, sync)
    uri = URI(url)
    params = { :api_key => ENV['VG_API_KEY'],
               :club_secret => ENV['VG_CLUB_SECRET'],
               :sync_from => sync }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end
end
