class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    p "MessagesIndex ?????? "*19
    @event = Event.find_by_id(params[:format])
    @messages = Message.where(event_id: @event.id)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    p @message
    @event = Event.find_by_id(params[:user_id])
    p "event: "+@event
    @events = Event.where(is_meetup: true)
    p "events: "+@events
    @concert = Concert.where(id: @event)
    p "concert"+@concert
    @concerts = Concert.where(artist: @concert.artist, time: @concert.datetime)
    p "concerts"+@concerts
    @message.event_id = @event.id
    @messages = Message.where(event_id: @event.id)
    p "messages"+@messages

  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new
    @message.event_id = params[:message][:event_id]
    @message.body = params[:message][:body]

    respond_to do |format|
      if @message.save
        format.html { redirect_to :back,  notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :event_id)
    end
end
