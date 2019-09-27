require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  before(:each) do
    assign(:user, FactoryBot.build_stubbed(:user, id: 1, name: 'Женька'))
    render
  end

  it 'renders player name' do
    expect(rendered).to match 'Женька'
  end

  context 'when user signed in' do
    before do
      sign_in FactoryBot.create(:user)
      render
    end

    it 'render button' do
      expect(rendered).to match 'Сменить имя и пароль'
    end
  end

  it 'when user not signed in button not render' do
    expect(rendered).not_to match 'Сменить имя и пароль'
  end

  it 'renders game fragments' do
    user = FactoryBot.create(:user)
    @games =[
      FactoryBot.create(:game,  user: user, current_level: 6, prize: 2000),
      FactoryBot.create(:game,  user: user, current_level: 3, prize: 0),
      FactoryBot.create(:game,  user: user, current_level: 4, prize: 500)
    ]
    stub_template 'users/_game.html.erb' => 'User game goes here'
    render
    expect(rendered).to have_content 'User game goes here'
  end
end