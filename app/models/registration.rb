class Registration < ApplicationRecord
 
  require 'base64'
  belongs_to :camp
  belongs_to :student
  has_one :family, through: :student
  
  attr_accessor :credit_card_number , :expiration_month , :expiration_year
  

  validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :student_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  
  validate :check_student_active, on: :create
  validate :check_camp_active, on: :create
  
  validate :student_rating
 
  
  validate :check_credit_card_number
  validate :check_expiration_date

  # scopes
  scope :for_camp, ->(camp_id) { where(camp_id: camp_id) }
  scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }

  # other methods
  def pay
    if self.payment == nil
        self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}****#{self.credit_card_number[-4..-1]}")
   
    end
  end

 private
  def student_rating
    return true if  student_id.nil? || camp_id.nil? 
    unless (student.rating).between?(camp.curriculum.min_rating, camp.curriculum.max_rating)
      errors.add(:base, "Student rating not within bounds")
    end
  end


  def check_student_active
       
        return if self.student.nil?
    errors.add(:student, "is not currently active") if !self.student.active
           
               
  end

  def check_camp_active
      return if self.camp.nil?
    errors.add(:camp, "is not currently active") if !self.camp.active
           
         
               
  end

 def credit_card
    CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end

  def check_credit_card_number
       return false if self.expiration_year.nil? || self.expiration_month.nil?
           
     if self.credit_card_number.nil? || credit_card.type.nil?
      errors.add(:credit_card_number, "is not valid")
      return false
     end
     true
    
    end

  def check_expiration_date
       return false if self.credit_card_number.nil? 
     if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
      errors.add(:expiration_date, "is expired")
      return false
    end
    true
    
  end
end
