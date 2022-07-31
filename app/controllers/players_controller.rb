class PlayersController < ApplicationController
  before_action :set_player, only: %i[ show edit update destroy ]

  # GET /players or /players.json
  def index
    if params[:team_id]
      @team = Team.find_by(id: params[:team_id])
      @players = @team.players
      render :team_players
    else
      @players = Player.all
    end
  end

  # GET /players/1 or /players/1.json
  def show
  end

  # GET /players/new
  def new
    if params[:team_id]
      @team = Team.find_by(id: params[:team_id])
      @player = @team.players.new
      render :team_new
    else
      @player = Player.new
      @teams = Team.all
    end
  end

  # GET /players/1/edit
  def edit
  end

  # POST /players or /players.json
  def create
    if params[:team_id]
      @team = Team.find_by(id: params[:team_id])
      @player = @team.players.new(player_params)
      if @team.save
        redirect_to @team
      else
        render :team_new
      end
    else
      @player = Player.new(player_params)
      respond_to do |format|
        if @player.save
          format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
          format.json { render :show, status: :created, location: @player }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @player.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /players/1 or /players/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1 or /players/1.json
  def destroy
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_params
      params.require(:player).permit(:name, :team_id)
    end
end
