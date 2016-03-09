class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  def self.find_by_artist

  end

  def search
  artist = params[:artist_name].gsub(" ","+")
  @user = User.find(params[:user_id])
  @response = HTTParty.get('http://www.nvivo.es/api/request.php?api_key=8d2007934293df8cbc2abe6192ee0f1b&method=artist.getEvents&artist='+artist+'&country_iso=us&format=json')
  @json = JSON.parse(@response.body).with_indifferent_access

  puts "_-"*44
  p @json['response']['gigs'][0]['name']
  p params

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
    @user = User.find(@concert.user_id)
    puts @user.inspect
    @carpool = "carpool"
  end

  # GET /concerts/new
  def new
    @user = User.find(params[:user_id])
    @concert = Concert.new
    @concerts = Concert.all
  end

  # GET /concerts/1/edit
  def edit
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(artist:params[:artist],venue:params[:venue],date:params[:date], user_id:params[:user_id])
    @concerts = Concert.all
    puts "-_"*70
    p @concert.venue
    p @concert.date
    p @concert.user_id

    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: 'Concert was successfully created.' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to @concert, notice: 'Concert was successfully updated.' }
        format.json { render :show, status: :ok, location: @concert }
      else
        format.html { render :edit }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
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
      @concert = Concert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def concert_params
      params.require(:concert).permit(:artist, :venue, :date, :user_id)
    end
end
