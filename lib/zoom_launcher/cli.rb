# frozen_string_literal: true

module ZoomLauncher
  class CLI < GoogleAuth
    CALENDAR = 'primary'
    ARGUMENTS = {
      single_events: true,
      order_by: 'startTime',
      time_min: Time.now.iso8601,
      q: 'zoom.us',
      max_results: 5
    }.freeze
    default_task :launch

    desc 'launch', 'Launch your next zoom meeting'
    def launch
      auth
      if next_event.meeting_url
        puts "Your next Zoom meeting is \"#{next_event.summary.bold}\"."
        is_was = next_event.already_started? ? 'was' : 'is'
        puts "It #{is_was} scheduled to start #{next_event.start_time_in_words}."
        puts

        if next_event.more_than_five_minutes_from_now?
          puts "Here's the Zoom URL: #{next_event.meeting_url.bold}"
        else
          puts "Opening #{next_event.meeting_url.bold}..."
          `open #{next_event.meeting_url}`

        end
        puts "Oh, and here's the URL in case you need it: #{next_event.html_link}"
      else
        puts "Can't find any upcomming Zoom meetings"
      end
    end

    desc 'auth', 'authorize CLI with Google Calendar'
    def auth
      calendar.authorization = user_credentials_for(
        Google::Apis::CalendarV3::AUTH_CALENDAR
      )
    end

    desc 'logout', 'Deauthorize this computer from accessing your calendar'
    def logout
      FileUtils.rm_rf token_store_path
    end

    no_commands do
      def calendar
        @calendar ||= Google::Apis::CalendarV3::CalendarService.new
      end

      def events
        @events ||= calendar.list_events(CALENDAR, ARGUMENTS)
      end

      def next_event
        @next_event ||= events.items.first
      end
    end
  end
end
