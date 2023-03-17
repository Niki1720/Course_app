class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :confirmable
         
  def to_s
    email
  end  
  
  has_many :courses  
  
    validate :must_have_a_role, on: :update
  
  extend FriendlyId
  friendly_id :email, use: :slugged
 
  def self.ransackable_attributes(auth_object = nil)
    ["email", "sign_in_count", "courses"]
  end
  
  def username
    self.email.split(/@/).first
  end
  
  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher) 
    end
  end
  
  private
  
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least one role")
    end
  end
end
