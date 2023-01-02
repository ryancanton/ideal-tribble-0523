# As a user,
# When I visit a movie's show page.
# I see the movie's title, creation year, and genre,
# and a list of all its actors from youngest to oldest.
# And I see the average age of all of the movie's actors
require 'rails_helper'

RSpec.describe "The Movie show page" do
  it 'Meets the user story requirements commented above' do
    ghibli = Studio.create!(name: "Studio Ghibli", location: "Japan")
    hmc = ghibli.movies.create!(title: "Howl's Moving Castle", creation_year: "2004", genre: "Adventure")
    c_bale = Actor.create!(name: "Christian Bale", age: 47)
    b_crystal = Actor.create!(name: "Billy Crystal", age: 52)
    j_hutcherson = Actor.create!(name: "Josh Hutcherson", age: 26)
    MovieActor.create!(movie_id: hmc.id, actor_id: c_bale.id)
    MovieActor.create!(movie_id: hmc.id, actor_id: b_crystal.id)
    MovieActor.create!(movie_id: hmc.id, actor_id: j_hutcherson.id)

    visit "/movies/#{hmc.id}"

    expect(page).to have_content(hmc.title)
    expect(page).to have_content(hmc.creation_year)
    expect(page).to have_content(hmc.genre)

    expect(page).to have_content("Actors:\nJosh Hutcherson, 26\nChristian Bale, 47\nBilly Crystal, 52")

    expect(page).to have_content("Average Actor Age: #{hmc.actor_age_avg}")
  end
end