require 'rubygems'
require 'rdio'

class RdioTarget
  attr_accessor :token
  
  def initialize(token)
    @token = token
  end
    
  def add_tracks(tracks=[], user)
    Rdio::init_with_token(@token)
    # TODO get the playlist, if it exists just add the tracks
    r_tracks = tracks.map { |track| Rdio::Track.search(track[:artist] + " " + track[:track],nil,['name']).first }
    if (!r_tracks.empty?)
      pl = Rdio::Playlist.create("Playlistify","Tracks and stuff. Music hack day hack.", r_tracks)
    end
  end
end