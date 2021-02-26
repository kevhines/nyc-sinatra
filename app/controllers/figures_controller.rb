class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/new'
  end

  post '/figures' do
   # binding.pry
    @figure = Figure.create(params[:figure])
    #binding.pry
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    #binding.pry
    @figure = Figure.find_by(id: params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    #binding.pry
    @figure = Figure.find_by(id: params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    #binding.pry
    if !params[:figure].keys.include?("title_ids")
      params[:figure]["title_ids"] = []
    end
    if !params[:figure].keys.include?("landmark_ids")
      params[:figure]["landmark_ids"] = []
    end
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure]) 
    if !params["title"]["name"].empty?
      @owner.titles << Title.create(name: params["title"]["name"])
    end
    if !params["landmark"]["name"].empty?
      @owner.landmarks << Landmark.create(name: params["landmark"]["name"])
    end
    
    
    redirect "/figures/#{@figure.id}"
  end


end
