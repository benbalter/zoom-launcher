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

In order to use Zoom Launcher, you need to create an OAuth app and authorize it to access your calendar. You can do it in four, not-so-easy steps:

1. Create a new project
    1. Go to https://console.developers.google.com
    2. Switch to your work account if need be (top right)
    3. Create a new project dropdown, top left next to your domain
2. Grant the project Calendar API access
    1. Click "Enable API"
    2. Type "Calendar" in the search box
    3. Click "Calendar API"
    4. Click "Enable"
3. Grab your creds
    1. Click "Credentials" on the left side
    2. Create a new OAuth credential with type "other"
    3. Download the credential to `~/.config/google/client_secrets.json` (icon, right side)
4. Run `zoom auth` and follow the instructions to authorize the app

## Project status

Rough-around-the-edges-but-it-usually-works-use-at-your-own-peril

## Pro-tip

Set Zoom to open with video and audio disabled for your own safety.
