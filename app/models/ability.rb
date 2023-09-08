# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'user'
      can %i[read create], :all
    else
      can :read, :all
    end
  end
end
