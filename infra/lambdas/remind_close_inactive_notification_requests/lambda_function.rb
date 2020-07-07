# frozen_string_literal: true

load_paths = Dir['./vendor/bundle/ruby/*/gems/**/lib']
$LOAD_PATH.unshift(*load_paths)

require 'nokogiri'

def lambda_handler(event:, context:)
  uri = URI.parse("#{ENV['BACKEND_URL']}/reminders/close_inactive_notification_requests")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri)
  http.request(request)
end
