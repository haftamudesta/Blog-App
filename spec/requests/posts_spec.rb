require 'rails_helper'

RSpec.describe PostsController, type: :request do
  subject do
    @user = User.new(
      name: 'haftamu',
      photo: 'https://www.facebook.com/photo/?fbid=4758353947565282&set=a.104394846294572',
      bio: 'full stack developer and elelctrical engineer', posts_counter: 20
    )
    @post = Post.new(title: 'Ruby on Rails', text: 'Ruby on Rails is the best framework', comments_counter: 15,
                     likes_counter: 10, author: @user)
  end

  before { subject.save }

  describe 'GET #index' do
    before(:each) { get user_posts_path(user_id: @user.id) }

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:index)
    end

    it 'contains correct placeholder text in the response body' do
      expect(response.body).to include('Posts')
    end
  end

  describe 'GET #show' do
    before(:each) { get user_post_path(user_id: @user.id, id: @post.id) }

    it 'returns http success' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template(:show)
    end

    it 'contains correct placeholder text in the response body' do
      expect(response.body).to include('Display posts')
    end
  end
end
