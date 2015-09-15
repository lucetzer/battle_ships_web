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
    #enter name in form
    #click submit
    expect(page).to have_content "Test"
  end
end
