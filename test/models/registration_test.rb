require 'test_helper'
require 'base64'

class RegistrationTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)

  
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:student_id).only_integer.is_greater_than(0)

  # set up context
  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_locations
      create_camps
      create_registrations
    end
    
   
    should "have an alphabetical scope" do
      assert_equal ["Ahmed, Rahil", "Kamath, Ashwini"], Registration.alphabetical.all.map{|r| r.student.name}
    end

  
  
    should "check student is active in the system" do
      create_inactive_students
      example = FactoryBot.build(:registration, student: @rahil, camp: @ec_camp)
      assert_not example.valid?
      
    example = FactoryBot.build(:registration, student: @iram, camp: @ec_camp)
      assert_not example.valid?
      
      
     end

    should "check camp is active in the system" do
     
     example = FactoryBot.build(:registration, student: @ashwini, camp: @khor_camp)
      assert_not example.valid?
    end

    should "check that the student is within the range" do
      # verify that Sean (rating 1252) can register for endgames (700-1500)
      ashwini_reg = FactoryBot.build(:registration, student: @ashwini, camp: @ec_camp)
      assert ashwini_reg.valid?
      rahil_reg = FactoryBot.build(:registration, student: @rahil, camp: @ec_camp)
      assert_not rahil_reg.valid?
    end

    should "detect valid and invalid expiration dates" do
        
      @ashwini_reg.expiration_year = Date.current.year
      assert @ashwini_reg.valid?
      
      @ashwini_reg.credit_card_number = "78934678889012"
      @ashwini_reg.expiration_month = Date.current.month
      @ashwini_reg.expiration_year = 7.year.ago.year
      assert_not @ashwini_reg.valid?
    end

    should "have a properly formatted payment receipt that only is generated once" do
      @ashwini_reg.payment = nil
      assert @ashwini_reg.save
      @ashwini_reg.credit_card_number = "4123456789012"
      @ashwini_reg.expiration_month = Date.current.month + 1
      @ashwini_reg.expiration_year = Date.current.year
      assert @ashwini_reg.valid?
      # test that payment receipt created
      @ashwini_reg.pay
      assert_equal "camp: #{@ashwini_reg.camp_id}; student: #{@ashwini_reg.student_id}; amount_paid: #{@ashwini_reg.camp.cost}****#{@ashwini_reg.credit_card_number[-4..-1]}", Base64.decode64(@ashwini_reg.payment)
     
    end


   
  end
end