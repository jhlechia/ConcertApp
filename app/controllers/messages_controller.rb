class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @event = Event.find_by_id(params[:format])
    @messages = Message.where(event_id: @event.id)
    @user = current_user
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
    @event = Event.find_by_id(params[:user_id])
    @events = Event.where(is_meetup: true)
    @concert = Concert.where(id: @event)
    @concerts = Concert.where(artist: @concert.artist, time: @concert.datetime)
    @message.event_id = @event.id
    @messages = Message.where(event_id: @event.id)

  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new
    if params[:message][:carpool] != "true"
      @message.event_id = params[:message][:event_id]
    else
      @message.event_id = Event.where(is_carpool: true).last.id
    end
    @message.body = params[:message][:body]
    @message.body.prepend("/~/").prepend(params[:message][:name])
    p "SDM      "*19
    p @message

    respond_to do |format|
      if @message.save
        format.html { redirect_to :back,  notice: 'Your message has been posted!' }
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
