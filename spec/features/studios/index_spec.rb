# As a user,
# When I visit the studio index page,
# Then I see all of the studios including name and location,
# And under each studio I see all of the studio's movies
# including the movie's title, creation year, and genre
require 'rails_helper'

RSpec.describe 'The Studio index page' do
  it 'meets the expectations of user stpry 1' do
    studio_1 = Studio.create!(name: "MCU", location: "LA")
    iron_man = studio_1.movies.create!(title: "Iron Man", creation_year: "2008", genre: "Action")
    ant_man = studio_1.movies.create!(title: "Ant Man", creation_year: "2017", genre: "Comedy")

    studio_2 = Studio.create!(name: "Studio Ghibli", location: "Japan")
    prin_mon = studio_2.movies.create!(title: "Princess Mononoke", creation_year: "1997", genre: "Action")
    kiki = studio_2.movies.create!(title: "Kiki's Delivery Service", creation_year: "1998", genre: "Comedy")

    visit "/studios"

    within "div#studio-#{studio_1.id}" do
      expect(page).to have_content(studio_1.name)
      expect(page).to have_content(studio_1.location)
      expect(page).to have_content(iron_man.title)
      expect(page).to have_content(ant_man.title)

      expect(page).to_not have_content(studio_2.name)
      expect(page).to_not have_content(studio_2.location)
      expect(page).to_not have_content(prin_mon.title)
      expect(page).to_not have_content(kiki.title)
    end

    within "div#movie-#{iron_man.id}" do
      expect(page).to have_content(iron_man.title)
      expect(page).to have_content(iron_man.creation_year)
      expect(page).to have_content(iron_man.genre)
    end
    within "div#movie-#{ant_man.id}" do
      expect(page).to have_content(ant_man.title)
      expect(page).to have_content(ant_man.creation_year)
      expect(page).to have_content(ant_man.genre)
    end

    within "div#studio-#{studio_2.id}" do
      expect(page).to have_content(studio_2.name)
      expect(page).to have_content(studio_2.location)
      expect(page).to have_content(prin_mon.title)
      expect(page).to have_content(kiki.title)

      expect(page).to_not have_content(studio_1.name)
      expect(page).to_not have_content(studio_1.location)
      expect(page).to_not have_content(iron_man.title)
      expect(page).to_not have_content(ant_man.title)
    end

    within "div#movie-#{prin_mon.id}" do
      expect(page).to have_content(prin_mon.title)
      expect(page).to have_content(prin_mon.creation_year)
      expect(page).to have_content(prin_mon.genre)
    end
    within "div#movie-#{kiki.id}" do
      expect(page).to have_content(kiki.title)
      expect(page).to have_content(kiki.creation_year)
      expect(page).to have_content(kiki.genre)
    end

  end
end