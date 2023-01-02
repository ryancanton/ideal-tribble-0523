require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many :actors}
  end

  describe '#actor_age_avg' do
    it 'returns the average age of all actors in a movie' do
      ghibli = Studio.create!(name: "Studio Ghibli", location: "Japan")
      hmc = ghibli.movies.create!(title: "Howl's Moving Castle", creation_year: "2004", genre: "Adventure")
      c_bale = Actor.create!(name: "Christian Bale", age: 47)
      b_crystal = Actor.create!(name: "Billy Crystal", age: 52)
      j_hutcherson = Actor.create!(name: "Josh Hutcherson", age: 26)
      MovieActor.create!(movie_id: hmc.id, actor_id: c_bale.id)
      MovieActor.create!(movie_id: hmc.id, actor_id: b_crystal.id)
      MovieActor.create!(movie_id: hmc.id, actor_id: j_hutcherson.id)

      expect(hmc.actor_age_avg).to eq(41.67)
    end
  end
end
