#!/usr/bin/env ruby
$LOAD_PATH << './lib'
$LOAD_PATH << '.'
require 'sources/lastfm_source.rb'
require 'targets/rdio_target.rb'
require 'sinatra'
require 'omniauth-rdio'

# TODO i don't think i should be using sessions here, but don't want to deal with anything fancy right now
use Rack::Session::Pool
# TODO could be moved to some source init type deal
use OmniAuth::Builder do
  provider :rdio, ENV['RDIO_CONSUMER_KEY'], ENV['RDIO_CONSUMER_SECRET']
end

get '/' do
  erb :index
end

get '/get_tracks.json' do
  begin
    # TODO right now we just pick this source, does not matter what the user selects
    source = LastfmSource.new(ENV['LASTFM_API_KEY'], ENV['LASTFM_API_SECRET'])
  
    tracks = if (params.has_key?("lastfm-loved-username"))
      source.get_tracks(:loved_tracks, params["lastfm-loved-username"])
    elsif (params.has_key?("lastfm-7day-username"))
      source.get_tracks(:top_tracks_7day, params["lastfm-7day-username"])
    end
    session[:tracks] = tracks
    tracks.to_json
  rescue => e
    puts e.backtrace
    [500, '{"error" : "Failed to playlistify: ' + e.to_s + '"}']
  end
end

get '/add_to_playlist' do
  erb :add_to_playlist
end

get '/add_to_playlist.json' do
  begin
    # TODO right now we just pick this target, does not matter what the user selects
    tracks = session[:tracks]  
    if (tracks == nil || tracks.empty?)
      [500,'{"error" : "There were no tracks to add to the playlist"}']
    else
      target = RdioTarget.new(session[:access_token])
      target.add_tracks(tracks, session[:rdiouid])
      '{"complete" : "true"}'
    end
  rescue NoMethodError => e
    puts e # that rdio library bug
    '{"complete" : "true"}'
  rescue => e
    puts e.backtrace
    [500, '{"error" : "Failed to playlistify: ' + e.to_s + '"}']
  end
end

get '/auth/rdio/callback' do
  session[:access_token] = request.env['omniauth.auth']["extra"]["access_token"]
  session[:rdiouid] = request.env['omniauth.auth']["uid"]
  redirect '/add_to_playlist'
end

get '/auth/failure' do
  # TODO
  puts("oh shit, auth failed: " + params[:message])
end