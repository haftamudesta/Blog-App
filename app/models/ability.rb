class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(role: 'guest')

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can %i[read create], :all
      can :destroy, Post do |post|
        post.author == user
      end
      can :destroy, Comment do |comment|
        comment.author == user
      end
    else
      can :read, :all
    end
  end
end
