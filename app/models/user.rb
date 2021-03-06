class User < ActiveRecord::Base

  before_validation :set_default_role

  has_many :orders
  has_many :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  attr_accessor :accessible

  ROLES = %w[admin user]

  validates :name, :role, presence: true
  validates :role, inclusion: { in: ROLES }

  private

    def set_default_role
      self.role = "user" if role.nil?
    end

    def mass_assignment_authorizer(role = :default)
      super + (accessible || [])
    end
end
