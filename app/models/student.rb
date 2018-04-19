class Student < ApplicationRecord
    
  belongs_to :family
  has_many :registrations
  has_many :camps, through: :registrations
  
  
  validates :first_name , presence: true
  validates :last_name  , presence: true
  validates :family_id  , presence: true ,  numericality: { only_integer: true, greater_than: 0 }
  validates_date :date_of_birth, :before => lambda { Date.today }, allow_blank: true, on: :create
  validates :rating, numericality: { only_integer: true, allow_blank: true , less_than_or_equal_to: 3000 , greater_than_or_equal_to: 0} 
 
  
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :below_rating, ->(ceiling) { where('rating < ?', ceiling) }
  scope :at_or_above_rating, ->(floor) { where('rating >= ?', floor) }
  
  #methods
 before_save :set_to_zero
  def set_to_zero
    self.rating ||= 0
  end
    before_destroy :check
    def check
      flag = 1
      self.camps.map do |camp|
          if camp.end_date < Date.today
              flag = 0
          end
      end
      if (flag == 0)
          errors.add(:student, "unable to destroy  camp")
          throw(:abort)
          
       end
   end
   
  def age
    return nil if date_of_birth.blank?
    rn = Time.now.to_s(:number).to_i
    dob = date_of_birth.to_time.to_s(:number).to_i
    (rn- dob)/10e9.to_i
  end
     
      
  def name
    "#{self.last_name}, #{self.first_name}"
  end
  
  def proper_name
    "#{self.first_name} #{self.last_name}"
  end
  

  end
