class User < ApplicationRecord
  has_secure_password
  
  validates :username, presence: true, uniqueness: { case_sensitive: false}
  validates :role, inclusion: { in: %w[admin instructor parent]}
  validates_format_of :phone, with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu))\z/i
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation,  on: :create 
  validates_confirmation_of :password
  validates_length_of :password, minimum: 4, allow_blank: true
  
  before_save :reformat_phone

  def reformat_phone
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end
 
end
