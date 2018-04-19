class Family < ApplicationRecord
      
  belongs_to :user
  has_many :students
  has_many :registrations, through: :students
  
  
   validates :family_name , presence: true
   validates :parent_first_name , presence: true
   
   delegate :email, to: :user, allow_nil: true
    delegate :username, to: :user, allow_nil: true
    delegate :phone, to: :user, allow_nil: true
  
 
   scope :alphabetical, -> { order('family_name') }
 scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

 
   before_destroy :check_destroy 
   before_update :if_family_inactive


  
  def check_destroy
      errors.add(:family, "can't be destroyed")
      throw(:abort)
  end
  
  def make_inactive
      self.active = false
      self.save
      
      
  end
 def if_family_inactive
    if self.active == false
     remove_future_registrations
     inactive_students
    end
  end

  def remove_future_registrations
    self.registrations.select{|r| r.camp.start_date >= Date.current}.each{|r| r.destroy}
  end

  def inactive_students
    self.students.each{|s| s.active = false}
  end
    
   

 
end
