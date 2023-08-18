require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    @user = User.create(name: 'haftamu', photo: 'https://www.facebook.com/photo/?fbid=1362909880443056&set=a.104394846294572', bio: 'full stack developer and electrical engineer',
                        posts_counter: 12)
    @post = Post.create(title: 'React fundamentals', text: 'the best book to read', comments_counter: 20, likes_counter: 20,
                        author: @user)
  end

  before { subject.save }

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it 'title should be b/w 3 and 250 words' do
    subject.title = 'a' * 200
    expect(subject).to be_valid
  end

  it 'title should not be empty' do
    subject.title = ' '
    expect(subject).to_not be_valid
  end

  it 'title should have valid value' do
    expect(subject.title).to eql 'React fundamentals'
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'text should have valid value' do
    expect(subject.text).to eql 'the best book to read'
  end

  it 'comments_counter must be integer' do
    subject.comments_counter = 12
    expect(subject).to be_valid
  end

  it 'comments_counter should have valid value' do
    subject.comments_counter = 12.2
    expect(subject).to_not be_valid
  end

  it 'comments_counter must not be less than 1' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter must be integer' do
    subject.likes_counter = 12
    expect(subject).to be_valid
  end

  it 'likes_counter should have valid value' do
    subject.likes_counter = 12.2
    expect(subject).to_not be_valid
  end

  it 'likes_counter must not be less than 1' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should return 5 recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.order(created_at: :desc).limit(5))
  end
end
