require 'rails_helper'

RSpec.describe 'user page', :focus, type: :system do
  before :each do
    @photo = 'https://unsplash.com/photos/F_-0BxGuVvo',
             @user1 = User.new(
               id: 4,
               name: 'Tom',
               photo: @photo,
               bio: 'Teacher from Mexico.',
               posts_counter: 0
             )
    post1 = Post.new(id: 1, title: 'Hello one',
                     text: 'this is mu first post',
                     likes_counter: 0,
                     comments_counter: 0,
                     author: @user1)
    Post.new(id: 2, title: 'Hello two', text: 'this is my second post', likes_counter: 0, comments_counter: 0,
             author: @user1)
    Post.new(id: 3, title: 'Hello three', text: 'This is my third post', likes_counter: 0, comments_counter: 0,
             author: @user1)
    Post.new(id: 4, title: 'Hello four', text: 'this is my fourth post', likes_counter: 0, comments_counter: 0,
             author: @user1)
    Comment.new(author: @user1, post: post1, text: 'first comment')
    Like.new(author: @user1, post: post1)
  end
  describe 'show page' do
    it 'should show the user profile picture' do
      visit users_path(user_id: 4)
      # expect(page).to have_css("img[src*='#{@user1.photo}']")
      expect(page).to have_selector('img[src="https://unsplash.com/photos/F_-0BxGuVvo"]')
    end
    it 'should show the username' do
      visit user_path(id: 4)
      expect(page).to have_content("User Name:#{@user1.name}")
    end
    it 'should show the number of posts by username' do
      visit user_path(id: 4)
      expect(page).to have_content('Number of posts: 6')
    end

    it 'should show user bio' do
      visit user_path(id: 4)
      expect(page).to have_content('Teacher from Mexico.')
    end

    it 'should show the last 3 posts' do
      visit user_path(id: 4)
      last_post = page.all('.each_post').count
      expect(last_post).to eq(3)
    end
    it 'should have a button that lets view all user posts' do
      visit user_path(id: 4)
      expect(page).to have_link(class: 'see_all_posts_btn')
    end

    it 'should redirected to specific post page' do
      visit user_path(id: 4)
      page.all(:link, 'link_each_post').last.click
      expect(page).to have_current_path('/users/4/posts/4')
    end
    it 'should redirected to index post page' do
      visit user_path(id: 4)
      page.all(:link, class: 'see_all_posts_btn').last.click
      expect(page).to have_current_path('/users/4/posts')
    end
  end
end
