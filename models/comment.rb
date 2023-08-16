class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'
  after_save :update_comments_counter

  private

  def update_comments_counter
    post.increment!(:coments_counter)
  end
end
# this comment is to check whether my models are pushed or not
