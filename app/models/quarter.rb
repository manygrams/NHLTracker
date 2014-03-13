class Quarter < ActiveRecord::Base
  attr_accessible :ends_at, :starts_at

  has_many :games

  def self.current
    Quarter.where("'#{Time.now.utc}' BETWEEN starts_at AND ends_at").first
  end
end
