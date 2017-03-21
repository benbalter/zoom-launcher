require 'webmock/rspec'
require 'timecop'

Timecop.freeze(Time.local(2016))
require_relative "../lib/zoom_launcher"

RSpec.configure do |config|
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.order = :random
  Kernel.srand config.seed

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end

WebMock.disable_net_connect!

def fixture_path(fixture)
  File.expand_path "./fixtures/#{fixture}", File.dirname(__FILE__)
end

def fixture_contents(fixture)
  File.read(fixture_path(fixture))
end

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end

  result
end

ENV["GOOGLE_CLIENT_SECRETS"] = fixture_path("client_secrets.json")
ENV["GOOGLE_CREDENTIAL_STORE"] = fixture_path("credentials.yml")
