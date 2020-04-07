# frozen_string_literal: true

require 'net/http'
require 'uri'
namespace :vg_users do
  task get_users: :environment do
    @url = 'https://api.virtuagym.com/api/v1/club/25396/member'
    response = get(@url)
    @users = response['result']
    if response['status']['results_remaining'] > 0
      sync = response['status']['next_page']
      response = get(@url, sync)
      @users += response['result']
    end
    @users.each do |user|
      u = User.find_by(email: user['email'])
      u.city = user['place']
      u.save!
      p "user #{u.email} is updated"
    end
  end

  def get(url, sync = nil)
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
