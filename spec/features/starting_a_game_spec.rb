require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'When I submit my name' do
    visit '/'
    click_link 'New Game'
    fill_in 'name', with: 'Joe'
    click_button 'New Game'
    expect(page).to have_content "Joe's awesome game"
  end

  scenario "When I don't submit my name" do
    visit '/'
    click_link 'New Game'
    fill_in 'name', with: ''
    click_button 'New Game'
    expect(page).to have_content "Please enter your name."
  end

end
