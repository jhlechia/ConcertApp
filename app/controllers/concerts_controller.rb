class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :new, :edit, :update, :destroy]

  def self.find_by_artist

  end

  def search
  artist = params[:artist_name].gsub(" ","+")
  @response = HTTParty.get('http://www.nvivo.es/api/request.php?api_key=8d2007934293df8cbc2abe6192ee0f1b&method=artist.getEvents&artist='+artist+'&country_iso=us&format=json')
  @json = JSON.parse(@response.body).with_indifferent_access

  puts "_-"*44
  p @json['response']['gigs'][0]['name']
  p params


  # @json['response']['gigs'].each do |item|
  #   p item['name']
  #   p item['venue']['name']
  #   p item['venue']['location']['city']
  # end
  end

  # GET /concerts
  # GET /concerts.json
  def index
    @concerts = Concert.all
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show
    # render json: params
    # @concert.user_id = params[:user_id]
    @user = User.find(@concert.user_id)
    puts @user.inspect
    @carpool = "carpool"
  end

  # GET /concerts/new
  def new
    @user = User.find(params[:user_id])
    @concerts = Concert.all
    @my_id = params[:user_id]
  end

  # GET /concerts/1/edit
  def edit
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(artist:params[:artist],venue:params[:venue],date:params[:date], user_id:params[:user_id])
    @concerts = Concert.all



    respond_to do |format|
      if @concert.save
        format.html { redirect_to user_path(params[:user_id]), notice: 'Concert was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update

  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to concerts_url, notice: 'Concert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_concert
      @concert = Concert.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:artist, :venue, :date, :user_id)
    end
end
