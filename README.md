# Zoom Launcher

A command line tool for joining your next Zoom meeting.

## Usage

```
$ zoom
Your next Zoom meeting is "Some important meeting".
It is scheduled to start in 3 minutes.

Opening https://github.zoom.us/j/XXX...
Oh, and here's the URL in case you need it: https://www.google.com/calendar/event?eid=XXX
```

## Installation

`gem install zoom_launcher`

## Setup

In order to use Zoom Launcher, you need to create an OAuth app and authorize it to access your calendar:

1. Go to https://console.developers.google.com and create a new project (you may need to switch to your work account)
2. Click "Credentials" on the left side and create a new credential for that project
3. Create a new OAuth credential, and download the resulting JSON file
4. Move the file to `~/.config/google/client_secrets.json`
5. Run `zoom auth` and follow the instructions to authorize the app

## Project status

Rough-around-the-edges-but-it-usually-works-use-at-your-own-peril

## Pro-tip

Set Zoom to open with video and audio disabled for your own safety.
