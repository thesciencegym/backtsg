require 'net/http'
require 'uri'
class User < ApplicationRecord
  has_many :orders

  def self.get_VG_users
    @url = 'https://api.virtuagym.com/api/v1/club/25396/member'
    response = get(@url)
    @users = response['result']
    if response['status']['results_remaining'] > 0
      sync = response['status']['next_page']
      response = get(@url, sync)
      @users += response['result']
    end
    @users.each do |user|
      # new_user = User.find_or_create_by(first_name: user['firstname'], last_name: user['lastname'],
      #                       email: user['email'], member_id: user['member_id'],
      #                       mobile: user['mobile'], vg_user_id: user['user_id'],
      #                       gender: user['gender'])
      old_user = User.find_by(email: user['email'])
      old_user.timestamp_edit = user['timestamp_edit']
      old_user.save!
      p "user #{old_user.email} is found or created"
    end
  end

  def self.get(url, sync = nil)
    uri = URI(url)
    params = { :api_key => ENV['VG_API_KEY'],
               :club_secret => ENV['VG_CLUB_SECRET'] }
    if sync
      params[sync.split('=')[0]] = sync.split('=')[1]
    end
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    JSON.parse(res.body)
  end
end
