require "rails_helper"
RSpec.describe "user, Index page",:focus,type: :intgration  do
    before:each do
        @user1 = User.new(
            id:6,
            name: 'haftamu', photo: 'https://www.facebook.com/photo/?fbid=4758353947565282&set=a.104394846294572',bio: 'full stack developer',posts_counter:0)
        Post.new(
            id: 20,
            title: 'rails test',
            text: 'rails integration test',
            likes_counter: 0,
            comments_counter: 0,
            author: @user1
          )
      end
    it("views users page") do
        visit ('/')
    expect(page).to have_content("All Users")
    end
    it("can see user name off all other users") do
    visit('/')
    expect(page).to have_content("User Name:#{@user1.name}")
    end
end