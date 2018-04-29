class ReplayMsgsController < ApplicationController
  before_action :set_replay_msg, only: [:edit, :update, :destroy]

  # GET /replay_msgs
  # GET /replay_msgs.json
  def index
    @replay_msgs = ReplayMsg.all
  end

  # GET /replay_msgs/new
  def new
    @replay_msg = ReplayMsg.new
  end

  # GET /replay_msgs/1/edit
  def edit
  end

  # POST /replay_msgs
  # POST /replay_msgs.json
  def create
    @replay_msg = ReplayMsg.new(replay_msg_params)

    respond_to do |format|
      if @replay_msg.save
        format.html { redirect_to replay_msgs_path, notice: 'Replay msg was successfully created.' }
        format.json { render :index, status: :created, location: @replay_msg }
      else
        format.html { render :index }
        format.json { render json: @replay_msg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replay_msgs/1
  # PATCH/PUT /replay_msgs/1.json
  def update
    respond_to do |format|
      if @replay_msg.update(replay_msg_params)
        format.html { redirect_to  replay_msgs_path, notice: 'Replay msg was successfully updated.' }
        format.json { render :index, status: :ok, location: @replay_msg }
      else
        format.html { render :edit }
        format.json { render json: @replay_msg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replay_msgs/1
  # DELETE /replay_msgs/1.json
  def destroy
    @replay_msg.destroy
    respond_to do |format|
      format.html { redirect_to replay_msgs_url, notice: 'Replay msg was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_replay_msg
      @replay_msg = ReplayMsg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def replay_msg_params

      params.require(:replay_msg).permit(:react_msg, :react_including_msg, :replay)
    end
end
