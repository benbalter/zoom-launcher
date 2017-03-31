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

  before do
    url = api_base + args.map { |k, v| "#{k}=#{v}" }.join('&')
    body = fixture_contents('events.json')
    stub_request(:get, url).to_return(status: 200, body: body, headers: headers)
  end

  it 'creates the calendar' do
    expect(subject.calendar).to be_a(Google::Apis::CalendarV3::CalendarService)
  end

  it 'pulls events' do
    expect(subject.events.kind).to eql('calendar#events')
    items = subject.events.items
    expect(items.count).to eql(1)
    expect(items.first.location).to eql('https://foo.zoom.us/j/1245678')
  end

  it 'pulls the next event' do
    expect(subject.next_event.location).to eql('https://foo.zoom.us/j/1245678')
  end

  it 'launches' do
    expect(output).to include("Your next Zoom meeting is \"\e[1mTest Event\e[0m\"")
    expect(output).to include("Here's the Zoom URL: \e[1mhttps://foo.zoom.us/j/1245678\e[0m")
  end
end
