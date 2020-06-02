class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    @song.genre_ids = params[:genres]
    @song.save
    erb :'/songs/show', locals: {message: "Song successfully updated."}
  end


  post '/songs' do
    #binding.pry
    if !Song.find_by(name: params[:song][:name])
      song = Song.create(params[:song])

      if !params[:artist][:name].empty?
        # update song.artist to value as input by user
        song.artist = Artist.find_or_create_by(name: params[:artist][:name])
      end
    end
  end

  get '/songs/:slug/edit' do
   @song = Song.find_by_slug(params[:slug])
   erb :'/songs/edit'
 end



end
