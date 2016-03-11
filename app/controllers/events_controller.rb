class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    # @events = Event.all
    @concert = Concert.find_by(id: params[:user_id])
    @events = Event.where(concert_id: @concert.id)
    @event = Event.find_by(concert_id: @concert.id)
    @messages = Message.where(event_id: @event.id)


    if (params[:format] == 'carpool')
      @events = @events.where(is_carpool:true)
      @carpool = true
      @hide_new_meetup_button = true
      @hide_carpool_list = true
    else
      @events = @events.where(is_meetup:true)
    end


  end

  # GET /events/1
  # GET /events/1.json
  def show
    @user = User.find(@concert.user_id)

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

    if params[:carpool]
      @event.is_carpool = true
    else
      @event.is_meetup = true
    end
    @carpool = params[:carpool]
    @event.concert_id = params[:user_id]
    respond_to do |format|
      if @event.save
        format.html { redirect_to user_events_path(params[:user_id], @carpool), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
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
