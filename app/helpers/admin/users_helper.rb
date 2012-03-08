module Admin::UsersHelper
  def roles_collection
    User::ROLES.map { |role| [role.humanize, role] }
  end

  def role(user)
    user.try(:role) ? user.role : User::ROLES.last
  end
end
