class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    p "SDM   "*44
    @event = Event.find_by_id(params[:event_id])
    @user = User.find_by_id(current_user.id)
    @concert = Concert.find_by_id(params[:format])
    p @concert
    p "<>"*44
    p @concert

    @messages = []

    if params[:carpool] == "true"
      @events = Event.where(is_carpool: true, concert_id: @concert.id)
      @events.each do |e|
        @messages += e.messages
      end
    else
      @events = Event.where(is_meetup: true, concert_id: @concert.id)
    end
    p "<>"*44
    p @events
    p "<>"*44
    p @messages if !nil

    @event = Event.new
    @message = Message.new
  end

  # GET /events/1
  # GET /events/1.json
  def show

    @user = User.find_by_id(params[:id])
    if params[:format] != nil
      @event = Event.find_by_id(params[:format])
    else
      @event = @event_from_create
    end

    @concert = Concert.find_by_id(@event.concert_id)

    @events = Event.where(concert_id: @concert.id, is_meetup:true)
    @concerts = Concert.where(artist:@concert.artist, date:@concert.date)
    @messages = Message.where(event_id:@event.id)
    @carpool = params[:carpool]
    @message = Message.new

  end

  # GET /events/new
  def new
    # render json: params
    @user = User.find(params[:user_id])
    @event = Event.new

    if params[:format] == 'carpool'
      @event.is_carpool == true
    else
      @event.is_meetup == true
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    p "xo"*47


    if params[:carpool] == "true"
      @event.is_carpool = true
    else
      @event.is_meetup = true
    end

    p @event

    if @event.save
      if params[:carpool] == "true"
        p "$$$$$$$$$$$$  redirecting from carpool true $$$$$$$$$$$$$$$$$$"
        redirect_to user_events_path(current_user.id), notice: 'Event was successfully created.'
      else
        p "%%%%%%%%%%%%%   redirecting from carpool false %%%%%%%%%%%%%%%%"
        redirect_to user_events_path(user_id:params[:user_id],format:@event.concert_id,carpool:"false", event_id:@event.id), notice: 'Event was successfully created.'
      end
    else
      render :new
    end

  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private



  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:is_carpool, :is_meetup, :time, :location, :description, :concert_id)
  end
end
