class Instructor < ApplicationRecord
    
belongs_to :user
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors

  # validations
  validates_presence_of :first_name
  validates_presence_of :last_name
 

  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :needs_bio, -> { where(bio: nil) }
  scope :active, -> {where(active: true)}
   scope :inactive, -> {where(active: false)}
  

  # class methods
  def self.for_camp(camp)
    
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
 
  end

   before_update :deactive_user

  
   before_destroy :check
   def check
      flag = 1
      self.camps.map do |camp|
          if camp.end_date < Date.today
              flag = 0
          end
      end
      if (flag == 0)
          errors.add(:instructor, "unable to destroy  instructor")
          throw(:abort)
      else
        destroy_user_account
       end
   end

 

  
  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

  private
 
  def deactive_user
    if self.active == false && self.user == nil
      self.user.active = false
      
    end
  end
 
def destroy_user_account
    self.user.destroy
  end
  
    
end
