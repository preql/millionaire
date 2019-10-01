require 'rails_helper'

RSpec.feature 'USER looks another profile', type: :feature do
  let(:users) { [
    FactoryBot.create(:user, name: 'Женька', balance: 5000),
    FactoryBot.create(:user, name: 'Вадик', balance: 750000)
  ] }

  before(:each) do
    FactoryBot.create(:game, user: users[1], created_at: "2019-09-25 17:46:00",
                      updated_at: "2019-09-25 17:56:00", prize: 250000,
                      current_level: 13, finished_at: "2019-09-25 17:56:00",
                      audience_help_used: true, fifty_fifty_used: true)
    FactoryBot.create(:game, user: users[1], created_at: "2019-09-27 17:46:00",
                      updated_at: "2019-09-27 17:56:00", prize: 500000,
                      current_level: 14, friend_call_used: true)
    login_as users[0]
  end

  scenario 'successfully' do
    visit '/'

    expect(page).to have_content 'Женька'
    expect(page).to have_content 'Вадик'
    expect(page).to have_content '5 000 ₽'
    expect(page).to have_content '750 000 ₽'

    click_link 'Вадик'

    expect(page).to have_current_path '/users/2'

    expect(page).to have_content '500 000 ₽'
    expect(page).to have_content '27 сент., 17:46'
    expect(page).to have_content '13'
    expect(page).to have_content '250 000 ₽'
    expect(page).to have_content '25 сент., 17:46'
    expect(page).to have_content '14'

    expect(page).to have_content '50/50'
    expect(page).to have_no_link('Сменить имя и пароль')
    #save_and_open_page
  end
end