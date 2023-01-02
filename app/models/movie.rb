class Movie < ApplicationRecord
  belongs_to :studio
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  def actor_age_avg
    self.actors.average(:age).round(2)
  end
end
