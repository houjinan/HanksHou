class Ability
  include CanCan::Ability

  attr_accessor :controller
  def initialize(user)


    user ||= User.new
    if user.is_super_admin?
      can :manage, :all
      return
    end


  end
end