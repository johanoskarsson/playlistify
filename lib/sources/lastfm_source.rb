require 'rubygems'
require 'lastfm'

class LastfmSource
  attr_accessor :api_key, :api_secret
  
  def initialize(api_key, api_secret)
    @api_key = api_key
    @api_secret = api_secret
  end
  
  def collection
    [:top_tracks_7day, :loved_tracks]
  end

  def get_tracks(from_collection, user)
    lastfm = Lastfm.new(@api_key, @api_secret)
    tracks = case from_collection
    when :top_tracks_7day
      lastfm.user.get_top_tracks(user, period="7day")
    when :loved_tracks
      lastfm.user.get_loved_tracks(user)
    end
    
    tracks.map {|track| {:track => track["name"], :artist=>track["artist"]["name"]}}
  end
end
