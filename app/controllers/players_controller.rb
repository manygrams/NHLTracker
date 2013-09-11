class PlayersController < ApplicationController
  def index
    players = Player.all
    @ranked_players = players.sort_by { |player| -player.win_percent }

    respond_to do |format|
      format.html
      format.json { render json: @players }
    end
  end

  def show
    @player = Player.find(params[:id])
    @games = @player.games.last(10)
  end

  def new
    @player = Player.new

    respond_to do |format|
      format.html
      format.json { render json: @player }
    end
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(params[:player])

    if @player.save
      redirect_to root_url, notice: 'Player was successfully created.'
    else
      render action: "edit"
    end
  end

  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
end
