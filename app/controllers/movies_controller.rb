class MoviesController < ApplicationController

  def show
    id = params['id'] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    checkRedirect = false
    if (session[:ratings] !=nil or session[:sort] != nil) then
    
    if (session[:ratings] != nil) then
    if (params[:ratings] == nil) then
    params[:ratings] = session[:ratings]
    checkRedirect = true
    end
    end

    if (session[:sort] != nil) then
    if (params[:id] == nil) then
    params[:id] = session[:sort]
    checkRedirect = true
    end
    end
    
    if (checkRedirect == true) then
    flash.keep
    redirect_to :action => "index", :id => params[:id], :ratings => params[:ratings]
    end
    end



    @ratings = params[:ratings]
     if (@ratings != nil) then
     @checkedBox = params[:ratings]
     @checked = @checkedBox.keys
     session[:ratings] = params[:ratings]
     @all_ratings = Movie.getRatingsList
     else
     @all_ratings = Movie.getRatingsList
     @checked = @all_ratings
     end
     id = params[:id]
     
     if (id.eql?("by-title")) then
     @movies = Movie.where(:rating => @checked).order("title ASC")
     @bytitle = "hilite"
     session[:sort] = id
     elsif (id.eql?('by-date')) then
     @movies = Movie.where(:rating => @checked).order("release_date ASC")
     @bydate = "hilite"
     session[:sort] = id
     else 
     @movies = Movie.where(:rating => @checked)
     end 
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
