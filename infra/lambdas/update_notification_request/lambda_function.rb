# frozen_string_literal: true

load_paths = Dir['./vendor/bundle/ruby/*/gems/**/lib']
$LOAD_PATH.unshift(*load_paths)

require 'json'
require 'nokogiri'
require 'open-uri'

def lambda_handler(event:, context:)
  parsed_message = JSON.parse(event.dig('Records', 0, 'Sns', 'Message'))
  puts "receiving message: #{parsed_message}"

  status = retrieve_current_status(parsed_message)

  send_status_to_backend(status, ENV['BACKEND_URL'], parsed_message['id'])
end

def retrieve_current_status(message)
  response = StatusRetriever
             .const_get(message.dig('delivery_company', 'name').capitalize)
             .new(message['tracking_code'])
             .current_status
  puts "got response: #{response}"
  response
end

def send_status_to_backend(status, destiny_url, notification_request_id)
  uri = URI.parse("#{destiny_url}/notification_requests/#{notification_request_id}/status")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  request = Net::HTTP::Post.new(uri.request_uri)
  request.body = { content: status }.to_json
  request['SHARED-SECRET'] = ENV['SHARED_SECRET']
  http.request(request)
end

class StatusRetriever
  class Correios
    attr_accessor :parsed_page

    def initialize(code)
      doc = URI.open("https://vaichegar.com.br/index.php?id=#{code}")
      @parsed_page ||= Nokogiri::HTML(doc)
    end

    def current_status
      parsed_page.css('.explore-content').text.gsub(/\s+/, '')
    end
  end
end
