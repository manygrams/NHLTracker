class GamesController < ApplicationController
  NHL_TEAMS = {
    'Anaheim Ducks' => {
      short_name: 'ducks'
    },
    'Boston Bruins' => {
      short_name: 'bruins'
    },
    'Buffalo Sabres' => {
      short_name: 'sabres'
    },
    'Calgary Flames' => {
      short_name: 'flames'
    },
    'Carolina Hurricanes' => {
      short_name: 'hurricanes'
    },
    'Chicago Blackhawks' => {
      short_name: 'blackhawks'
    },
    'Colombus Blue Jackets' => {
      short_name: 'bluejackets'
    },
    'Colorado Avalanche' => {
      short_name: 'avalanche'
    },
    'Dallas Stars' => {
      short_name: 'stars'
    },
    'Detroit Red Wings' => {
      short_name: 'redwings'
    },
    'Edmonton Oilers' => {
      short_name: 'oilers'
    },
    'Florida Panthers' => {
      short_name: 'panthers'
    },
    'Los Angeles Kings' => {
      short_name: 'kings'
    },
    'Minnesota Wild' => {
      short_name: 'wild'
    },
    'Montreal Canadiens' => {
      short_name: 'canadiens'
    },
    'Nashville Predators' => {
      short_name: 'predators'
    },
    'New Jersey Devils' => {
      short_name: 'devils'
    },
    'New York Islanders' => {
      short_name: 'islanders'
    },
    'New York Rangers' => {
      short_name: 'rangers'
    },
    'Ottawa Senators' => {
      short_name: 'senators'
    },
    'Philadelphia Flyers' => {
      short_name: 'flyers'
    },
    'Phoenix Coyotes' => {
      short_name: 'coyotes'
    },
    'Pittsburgh Penguins' => {
      short_name: 'penguins'
    },
    'San Jose Sharks' => {
      short_name: 'sharks'
    },
    'St. Louis Blues' => {
      short_name: 'blues'
    },
    'Tampa Bay Lightning' => {
      short_name: 'lightning'
    },
    'Toronto Maple Leafs' => {
      short_name: 'mapleleafs'
    },
    'Vancouver Canucks' => {
      short_name: 'canucks'
    },
    'Washington Capitals' => {
      short_name: 'capitals'
    },
    'Winnipeg Jets' => {
      short_name: 'jets'
    }
  }

  def show
    @game = Game.find(params[:id])
    @home = Player.find(@game.home_player_id)
    @away = Player.find(@game.away_player_id)

    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end

  def new
    @game = Game.new
    @players = Player.all.sort_by { |p| p.name.downcase }.map { |p| [ p.name, p.id ] }
    @teams = NHL_TEAMS

    respond_to do |format|
      format.html
      format.json { render json: @game }
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end
end
