class Ability
  include CanCan::Ability

  attr_accessor :controller

  def initialize(user)
    user ||= User.new
    if user.is_super_admin?
      can :manage, :all
      return
    else
      roles_for_anonymous
    end
  end


  def roles_for_anonymous
    cannot :manage, :all

  end

end