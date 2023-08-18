require_relative '../rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'haftamu', photo: 'https://www.facebook.com/photo/?fbid=1362909880443056&set=a.104394846294572', bio: 'Full stack developer') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should have valid value' do
    expect(subject.name).to eql 'haftamu'
  end
  it 'bio should have valid value' do
    expect(subject.bio).to eql 'Full stack developer'
  end


  it 'photo should have valid value' do
    expect(subject.photo).to eql 'https://www.facebook.com/photo/?fbid=1362909880443056&set=a.104394846294572'
  end

  it 'post_counter must not be less than 1' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should have posts counter greater than or euqal to 0' do
    subject.post_counter = 120
    expect(subject).to be_valid
  end

  it 'should return 3 recent posts' do
    expect(subject.recent_posts).to eq(subject.posts.order(created_at: :desc).limit(3))
  end
end
