# Playlistify

This is a tiny Music Hack day project to create playlists on various sites from various sources.

## Sources and targets supported
So far it only supports

**Source:** Last.fm loved tracks and Last.fm 7 day charts
**Target:** Rdio playlist

## Setup
In order to set this up you need to

    cp config.rb.example config.rb
    edit the config and put in the appropriate api keys
    deploy!

## Developing
You need some api keys. Just setting them as environmental variables for development will do.

Get these from http://www.last.fm/api/account

    LASTFM_API_KEY="..."
    LASTFM_API_SECRET="..."

Get these from http://developer.rdio.com/

    RDIO_CONSUMER_KEY="..."
    RDIO_CONSUMER_SECRET="..."

## TODO
This is a hack so there are tons of things not working properly. Look for TODOs in the code

**Rdio target**

 * This target just searches for the artist and track, picking whatever is returned first.
 * https://github.com/spudtrooper/rdiorb/issues/9


## Contributing
Feel free to send pull requests for changes, especially adding new sources and targets.

## Dependencies
I'm using a few libraries, thanks to everyone who made them happen.

 * [bootstrap](http://github.com/twitter/bootstrap)
 * [jQuery](http://jquery.com)
 * [rdiorb](https://github.com/spudtrooper/rdiorb)
 * [omniauth-rdio](https://github.com/nixme/omniauth-rdio)
 * [ruby-lastfm](https://github.com/youpy/ruby-lastfm)