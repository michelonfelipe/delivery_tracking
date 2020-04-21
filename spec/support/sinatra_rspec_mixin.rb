# frozen_string_literal: true

require 'rack/test'

module SinatraRSpecMixin
  include ::Rack::Test::Methods

  def app
    Sinatra::Application
  end
end
