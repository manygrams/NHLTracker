class Game < ActiveRecord::Base
  attr_accessible :away_player_id, :away_team, :away_player_score, :home_player_id, :home_player_score, :home_team

  scope :active, -> { where(quarter_id: Quarter.current) }

  belongs_to :home_player, class_name: 'Player'
  belongs_to :away_player, class_name: 'Player'
  belongs_to :quarter

  before_validation :find_or_create_quarter

  def get_side(player)
    if away_player_id == player.id
      'Away'
    elsif home_player_id == player.id
      'Home'
    end
  end

  def get_team_name(player)
    if away_player_id == player.id
      away_team
    elsif home_player_id == player.id
      home_team
    end
  end

  def get_opposition_player(player)
    if away_player_id == player.id
      Player.find(home_player_id)
    elsif home_player_id == player.id
      Player.find(away_player_id)
    end
  end

  def get_opposition_name(player)
    if away_player_id == player.id
      home_team
    elsif home_player_id == player.id
      away_team
    end
  end

  def get_score(player)
    if away_player_id == player.id
      away_player_score
    elsif home_player_id == player.id
      home_player_score
    end
  end

  def get_opposition_score(player)
    if away_player_id == player.id
      home_player_score
    elsif home_player_id == player.id
      away_player_score
    end
  end

  def won(player)
    if (away_player_id == player.id && away_player_score > home_player_score) || (home_player_id == player.id && home_player_score > away_player_score)
      true
    elsif away_player_id != player.id && home_player_id != player.id
      nil
    else
      false
    end
  end

  private

  def find_or_create_quarter
    q = Quarter.where("'#{Time.now.utc}' BETWEEN starts_at AND ends_at").first
    if q.nil?
      q = Quarter.new(starts_at: Time.now.utc.beginning_of_quarter, ends_at: Time.now.utc.end_of_quarter)
      q.save
    end

    self.quarter = q
  end
end
