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

#   As a user,
# When I visit a movie show page,
# I do not see any actors listed that are not part of the movie
# And I see a form to add an actor to this movie
# When I fill in the form with the ID of an actor that exists in the database
# And I click submit
# Then I am redirected back to that movie's show page
# And I see the actor's name is now listed
  it 'contains a from to add an existing actor to a movie' do
    ghibli = Studio.create!(name: "Studio Ghibli", location: "Japan")
    hmc = ghibli.movies.create!(title: "Howl's Moving Castle", creation_year: "2004", genre: "Adventure")
    c_bale = Actor.create!(name: "Christian Bale", age: 47)

    visit "/movies/#{hmc.id}"

    expect(find('form')).to have_content('Actor')
    fill_in 'Actor', with: "#{c_bale.id}"
    click_button 'Submit'

    expect(current_path).to eq("/movies/#{hmc.id}")
    expect(page).to have_content("Christian Bale, 47")
  end
end