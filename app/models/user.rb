class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
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
end
