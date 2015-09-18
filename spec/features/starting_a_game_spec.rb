require 'spec_helper'

feature 'Starting a new game' do
  scenario 'The homepage takes you to new player page' do
    visit '/'
    click_link 'Play Battleships'
    expect(page).to have_content "What's your name?"
  end

  scenario 'When I submit my name' do
    visit '/new_player'
    fill_in 'name', with: 'Dan'
    click_button 'submit'
    expect(page).to have_content "Hello, Dan!"
  end

  scenario "If I don't submit name" do
    visit '/new_player'
    fill_in 'name', with: ''
    click_button 'submit'
    expect(page).to_not have_content "Hello, Dan!"
  end

  scenario "Once name has been submitted, it takes to new board" do
    visit '/new_board'
    expect(page).to have_content "Select the position for your size 1 ship:"
  end
end

feature 'adding a ship' do
  scenario 'place a patrol boat on cells A1 and A2' do
    visit '/new_board'
    fill_in 'coord', with: 'A1'
    choose 'orientation', :match => :first
    click_button 'place ship'
    expect(page).to have_css("div[id='water']", count: 98)
  end

  # scenario 'place a patrol boat on cells E5 and E6' do
  #   visit '/add_ships'
  #   fill_in 'coord', with: 'E5'
  #   click_button 'horizontally'
  #   expect(page).to have_css('td#E5.Ship' & 'td#E6.Ship')
  # end


end
