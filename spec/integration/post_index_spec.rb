require 'rails_helper'

RSpec.describe 'Index posts page', :focus, type: :system do
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
    Comment.new(author: @user1, post: post1, text: 'Awesome post!')
    Like.new(author: @user1, post: post1)
  end
  describe 'index page' do
    it 'should show the user profile picture' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_css("img[src*='#{@photo}']")
    end

    it 'should show the username' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content("User Name:#{@user1.name}")
    end

    it 'should show the number of posts by the user' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('Number of posts: 6')
    end

    it 'should show the post title' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('Hello four')
    end

    it 'should show part of the post text' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('it is nice to work with')
    end

    it 'can see the first comment of the post' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('first comment')
    end

    it 'can see total post comments' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('Comments: 1')
    end

    it 'should show the total post likes' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_content('Likes: 0')
    end

    it 'should show the pagination' do
      visit user_posts_path(user_id: 4)
      expect(page).to have_link(class: 'pagination')
    end

    it 'should click on a post, it redirects to that posts show page' do
      visit user_posts_path(user_id: 4)
      page.all(:link, class: 'recent-posts-post').first.click
      expect(page).to have_current_path('/users/4/posts/1')
    end
  end
end
