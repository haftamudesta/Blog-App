require "rails_helper"
RSpec.describe "user, Index page",:focus,type: :intgration  do
    before:each do
        @photo = 'https://unsplash.com/photos/F_-0BxGuVvo',
        @user1 = User.new(
            id:6,
            name: 'Tom', photo: @photo,bio: 'full stack developer',posts_counter:0)
        Post.new(
            id: 20,
            title: 'rails test',
            text: 'rails integration test',
            likes_counter: 0,
            comments_counter: 0,
            author: @user1
          )
      end
      it 'should show the user profile picture' do
        visit users_path(user_id: 4)
        expect(page).to have_css("img[src*='#{@user1.photo}']")
      end


    it("views users page") do
    visit users_path
    expect(page).to have_content("All Users")
    end
    it("can see user name off all other users") do
    visit users_path
    expect(page).to have_content("User Name: #{@user1.name}")
    end

    it("can see number of posts each user has written") do
        visit users_path
        expect(page).to have_content('Number of posts: 6')
        end
        it 'When I click on a user, I am redirected to that users show page' do
            visit users_path
            page.all(:link, 'picture_link').last.click
            expect(page).to have_current_path('/users/4')
          end
end