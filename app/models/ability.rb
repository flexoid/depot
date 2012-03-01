class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, :all if user.try(:role) == 'admin'
  end
end
