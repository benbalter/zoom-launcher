# frozen_string_literal: true

module Google
  module Apis
    module CalendarV3
      class Event
        MEETING_URL_REGEX = %r{https://.*\.zoom\.us/j/\d+}
        include ActionView::Helpers::DateHelper

        def meeting_url
          matches = (location + description).match(MEETING_URL_REGEX)
          matches[0] if matches
        end

        def already_started?
          start.date_time <= DateTime.now
        end

        def more_than_five_minutes_from_now?
          start.date_time.to_time >= (DateTime.now.to_time + 5 * 60)
        end

        def start_time_in_words
          distance = time_ago_in_words(start.date_time)
          if already_started?
            "#{distance} ago".bold.red
          else
            "in #{distance}".bold
          end
        end
      end
    end
  end
end
