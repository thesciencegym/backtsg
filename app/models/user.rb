require 'net/http'
require 'uri'
class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :member_id, uniqueness: true, allow_nil: true

  has_many :orders

  def self.get_VG_users
    @url = 'https://api.virtuagym.com/api/v1/club/25396/member'
    sync = User.last.timestamp_edit
    response = get(@url, sync)
    @users = response['result']
    @users.each do |user|
      if User.exists?(member_id: user['member_id'])
        exist_user = User.find_by(member_id: user['member_id'])
        exist_user.update(email: user['email'], timestamp_edit: user['timestamp_edit']) if exist_user.email != user['email']
      elsif !User.exists?(email: user['email'])
        new_user = User.create!(first_name: user['firstname'], last_name: user['lastname'],
                            email: user['email'], member_id: user['member_id'],
                            mobile: user['mobile'], vg_user_id: user['user_id'],
                            gender: user['gender'], city: user['place'],
                            timestamp_edit: user['timestamp_edit'])
        p "user #{new_user.email} is found or created"
      else
        exis_user = User.find_by(email: user['email'])
        exis_user.update(member_id: user['member_id'], vg_user_id: user['user_id'], timestamp_edit: user['timestamp_edit'])  unless exis_user.member_id
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

  def member?
    url = "https://api.virtuagym.com/api/v1/club/25396/member/#{self.member_id}"
    uri = URI(url)
    params = { :api_key => ENV['VG_API_KEY'],
               :club_secret => ENV['VG_CLUB_SECRET'],
               :with => 'active_memberships' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    response = JSON.parse(res.body)
    !response['result'][0]['memberships'].empty?
  end
end
