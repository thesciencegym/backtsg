require 'json'
require 'net/https'

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
end
