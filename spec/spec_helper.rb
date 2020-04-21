# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require_relative '../app.rb'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f } # rubocop:disable Lint/NonDeterministicRequireOrder

RSpec.configure do |config|
  config.include SinatraRSpecMixin

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one? # rubocop:disable Style/IfUnlessModifier
    config.default_formatter = 'doc'
  end

  config.profile_examples = 5

  config.order = :random

  Kernel.srand config.seed
end
