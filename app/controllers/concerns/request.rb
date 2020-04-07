require 'json'
require 'net/https'
require 'uri'

module Request
  def self.post(url, body)
    headers = { "Content-Type": 'application/json' }
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.path, headers)
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.put(url, body)
    headers = { "Content-Type": 'application/json' }
    uri = URI.parse(url)
    params = { :api_key => ENV['VG_API_KEY'],
               :club_secret => ENV['VG_CLUB_SECRET'] }
    uri.query = URI.encode_www_form(params)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Put.new("#{uri.path}?#{uri.query}", headers)
    request.body = body.to_json
    response = http.request(request)
    JSON.parse(response.body)
  end
end
