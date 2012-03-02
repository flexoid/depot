class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.persisted? ? send(@user.role) : "guest"
  end

  def admin
    can :manage, Product
    can :manage, User
  end

  def user
  end

  def guest
  end
end
