class User < ApplicationRecord
  rolify

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :confirmable
         
  def to_s
    email
  end  
  
  has_many :courses    
  
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
end
