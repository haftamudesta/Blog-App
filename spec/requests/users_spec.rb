require 'rails_helper'

RSpec.describe UsersController, type: :request do
  subject { @user = User.new(name: 'haftamu', photo: 'https://www.facebook.com/photo/?fbid=4758353947565282&set=a.104394846294572', posts_counter: 20) }

  before { subject.save }

  describe 'GET #index' do
    before(:example) { get users_path }

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'contains correct placeholder text in the response body' do
      expect(response.body).to include('Users')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_path(id: @user.id) }

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'contains correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of users')
    end
  end
end
