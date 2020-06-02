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

        # index 0: params[:genre][:name]
        # index 1: params[:genre][ids]
        params[:genre].each_with_index do |genre_value, index|
          if index == 0
            if !params[:genre][:name].empty?
              # song.genres as input by user must be a new genre
              if Genre.find_by(name: params[:genre][:name])
                flash[:message] = "Genre already exists, please select from checklist"
              else
                song.genres << Genre.create(name: params[:genre][:name])
              end
            end
          elsif !params[:genre][:ids].empty?
            # song.genres as selected at checkbox
            params[:genre][:ids].each do |id|
              song.genres << Genre.find(id)
            end
          end
        end

        song.save

        # Flash Message when a new song is created
        flash[:message] = "Successfully created song."
      else
        # Flash Message when the new song already exists
        flash[:message] = "Song already exists."
      end

      redirect "/songs/#{song.slug}"
    end


  get '/songs/:slug/edit' do
   @song = Song.find_by_slug(params[:slug])
   erb :'/songs/edit'
 end



end
