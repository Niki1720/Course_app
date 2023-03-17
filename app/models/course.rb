class Course < ApplicationRecord
  validates :title, :short_description, :language, :level, :price, presence: true
  validates :description, presence: true, length: { :minimum => 5 }

  belongs_to :user
  has_rich_text :description
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  def to_s
    title
  end  
  
  LANGUAGES = [:"English", :"Russian", :"Polish", :"Spanish"]
  
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = [:"Beginner", :"Intermediate", :"Advanced"]
  
  def self.levels
    LEVELS.map { |level| [level, level] }
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["title", "language", "level", "price"]
  end
  
   def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
