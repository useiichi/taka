class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    if session[:user_id].nil?
      redirect_to :controller => 'sessions', :action => 'new'
      return
    elsif session[:user_id] % 2 == 1
      her_id = session[:user_id]
      my_id = session[:user_id] + 1
    else
      her_id = session[:user_id] - 1
      my_id = session[:user_id]
    end
    @messages = Message.where(userid: her_id).or(Message.where(userid: my_id)).order('id DESC').page(params[:page]).per(10)

    #respond_to do |format|

    #end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.userid = session[:user_id]

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        #format.mobile { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        #format.mobile { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if if @message.userid == session[:user_id]; @message.update(message_params) else false end
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        #format.mobile { redirect_to @message, notice: 'Message was successfully updated.' }
        #format.json { render :show, status: :ok, location: @message }
        format.json { head :no_content }
      else
        format.html { render :edit }
        #format.mobile { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy if @message.userid == session[:user_id]
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      #format.mobile { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
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
      params.require(:message).permit(:userid, :body)
    end
end
