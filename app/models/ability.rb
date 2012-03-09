class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new
    @user.persisted? ? send(@user.role) : send("guest")
  end

  def admin
    can :admin, :all
    can :manage, [Product, User, Cart, Order, Comment]
  end

  def user
    can :create, Order
    can :read, Order, user_id: @user.id
    can :show, Product
    can [:read, :create], Comment
  end

  def guest
    can :show, Product
  end
end
