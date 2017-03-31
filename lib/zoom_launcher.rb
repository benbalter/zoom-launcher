# frozen_string_literal: true

require 'dotenv'
require 'google/apis/calendar_v3'
require 'action_view'
require 'action_view/helpers'
require 'colored'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'thor'
require 'os'

require_relative 'google/apis/calendar_v3/event'

module ZoomLauncher
  autoload :CLI,        'zoom_launcher/cli'
  autoload :GoogleAuth, 'zoom_launcher/google_auth'
end
