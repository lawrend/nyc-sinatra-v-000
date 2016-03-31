class FiguresController < ApplicationController

  get '/figures' do 
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  post '/figures/new' do
    @figure = Figure.new(params[:figure])

    if !params[:title][:name].empty?
      @figure.titles << Title.new(name: params[:title][:name])
    end

    all_landmarks = params[:figure][:landmark_ids]
    if all_landmarks != nil
      all_landmarks.each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.new(name: params[:landmark][:name])
    end

    @figure.save

    redirect "/figures"
  end

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :'figures/show', locals: {message: "Figure successfully updated."}
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.titles = []
    @figure.update(params[:figure])
    if !params[:title][:name].empty?
      @figure.titles << Title.new(name: params[:title][:name])
    end
    @figure.landmarks = []
    all_landmarks = params[:figure][:landmark_ids]
    if all_landmarks != nil
      all_landmarks.each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.new(name: params[:landmark][:name])
    end
    @figure.save

    redirect "/figures/#{@figure.id}"

  end


  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

end
