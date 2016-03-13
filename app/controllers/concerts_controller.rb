class ConcertsController < ApplicationController
  before_action :set_concert, only: [:show, :edit, :update, :destroy]

  def self.find_by_artist

  end

  def search
    artist = params[:artist_name].gsub(" ","+")
    @user = User.find(params[:user_id])
    artist = 'kaka' if artist.nil?
    puts "Here is my artist #{artist.inspect}"
    @response = HTTParty.get('http://www.nvivo.es/api/request.php?api_key=8d2007934293df8cbc2abe6192ee0f1b&method=artist.getEvents&artist='+artist+'&country_iso=us&format=json')
    @json = JSON.parse(@response.body).with_indifferent_access


    if @json['status'] == "error"
      respond_to do |format|
        format.js {  render :js => "hide_spinner();" }
      end
    elsif @json['response']['gigs'][0] == nil
      respond_to do |format|
        format.js {  render :js => "hide_spinner();" }
      end
    end

  end

  # GET /concerts
  # GET /concerts.json
  def index
    @concerts = Concert.all
    @user = User.find_by_id(params[:format])
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show
    @user = User.find_by_id(params[:format])
    @concert = Concert.find_by_id(params[:id])
    @carpool = "carpool"
  end

  # GET /concerts/new
  def new
    @user = User.find(params[:user_id])
    @concert = Concert.new
    @concerts = Concert.all
    @hide_buttons = true
  end

  # GET /concerts/1/edit
  def edit
  end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(artist:params[:artist],venue:params[:venue],date:params[:date], image:params[:image], user_id:params[:user_id])
    @concerts = Concert.all
    @user = User.find(params[:user_id])


    respond_to do |format|
      if @concert.save
        format.html { redirect_to @user, notice: 'Concert was successfully added.' }
      else
        format.html { render :new }
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
  # def before_destroy
  #   p '*'* 44
  #   @concert = Concert.find_by(user_id: params[:format])
  #   @events = Event.where(concert_id: @concert.id)
  #
  #   @new_concert = Concert.where(artist: @concert.artist).where.not(user_id: params[:format])
  #   @events.each do |x|
  #     x.concert_id = @new_concert.id
  #   end
  #   @concert.destroy
  # end


  def destroy
    @concert.destroy
    redirect_to user_path(params[:format]), notice: 'Concert was successfully deleted.'
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
