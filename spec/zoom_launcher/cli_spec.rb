# frozen_string_literal: true

RSpec.describe ZoomLauncher::CLI do
  let(:api_base) { 'https://www.googleapis.com/calendar/v3/calendars/primary/events?' }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:output) { capture(:stdout) { subject.launch } }
  let(:args) do
    {
      "maxResults": 5,
      "orderBy": 'startTime',
      "q": 'zoom.us',
      "singleEvents": true,
      "timeMin": Time.now.iso8601
    }
  end

  %w[normal vanity].each do |type|
    context "#{type} room URLs" do
      let(:meeting_id) { type == 'normal' ? '1245678' : 'fancyroom' }
      let(:path) { type == 'normal' ? 'j' : 'my' }
      let(:meeting_url) { "https://foo.zoom.us/#{path}/#{meeting_id}" }
      let(:zoom_url) { "zoommtg://zoom.us/join?confno=#{meeting_id}" }

      before do
        url = api_base + args.map { |k, v| "#{k}=#{v}" }.join('&')
        body = fixture_contents("#{type}.json")
        stub_request(:get, url).to_return(status: 200, body: body, headers: headers)
      end

      it 'creates the calendar' do
        expect(subject.calendar).to be_a(Google::Apis::CalendarV3::CalendarService)
      end

      it 'pulls events' do
        expect(subject.events.kind).to eql('calendar#events')
        items = subject.events.items
        expect(items.count).to eql(1)
        expect(items.first.location).to eql(meeting_url)
      end

      it 'pulls the next event' do
        expect(subject.next_event.location).to eql(meeting_url)
      end

      it 'parses the meeting id' do
        expect(subject.next_event.meeting_id).to eql(meeting_id)
      end

      it 'generates the meeting url' do
        expect(subject.next_event.meeting_url.to_s).to eql(meeting_url)
      end

      it 'generates the zoom url' do
        if type == 'normal'
          expect(subject.next_event.zoom_url).to eql(zoom_url)
        else
          expect(subject.next_event.zoom_url).to be_nil
        end
      end

      it 'launches' do
        expect(output).to include("Your next Zoom meeting is \"\e[1mTest Event\e[0m\"")
        expect(output).to include("Here's the Zoom URL: \e[1m#{meeting_url}\e[0m")
      end
    end
  end
end
