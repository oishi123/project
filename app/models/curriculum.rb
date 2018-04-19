class Curriculum < ApplicationRecord
  

  # relationships
  
  has_many :camps

  # validations
  validates :name, presence: true , uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }

   before_destroy :cannot_destroy
   before_update :check_reg_b4_making_inactive
   
   def cannot_destroy
     errors.add(:curriculum , "cant be destroyed")
     throw(:abort)
    end 
    
    
    # def check_reg_b4_making_inactive
      
    #     count = 0
    #     self.camps.map do |camp|
    #       if camp.start_date >= Date.today
    #         camp.registrations.map do |reg|
    #           count += 1
    #       end
    #     end
    #   end
      
    #   if count > 0
    #       self.active = true
    #     end
    #   end
    
  
     

  private
  def max_rating_greater_than_min_rating
    # only testing 'greater than' in this method, so...
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
 end


end
