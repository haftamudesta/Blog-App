require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text:"ruby on rails") }
  before {subject.save}

  it('it should be present') do
    subject.text=nil
expect(subject).to_not be_valid
  end
end
