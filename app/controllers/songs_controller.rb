require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/songs' do
    @songs = Song.all

    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs' do
    @song = Song.create(:name => params["Name"])
    @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully created song."

    redirect("/songs/#{@song.slug}")
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])

    erb :'/songs/show'
  end

  patch '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @song.name = params["Name"]
    @song.artist = params["Artist Name"]
    @song.genres_id = params[:genres]
    @song.save
    flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end

end
