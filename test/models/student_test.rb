require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:family)
  should have_many(:registrations)
 #should have_many(:camps).through(:registrations)

 
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)
  should validate_numericality_of(:family_id).only_integer.is_greater_than(0)
  
  should allow_value(22.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)
  should_not allow_value(1.day.from_now.to_date).for(:date_of_birth)
  should_not allow_value("bad").for(:date_of_birth)
  should_not allow_value(10).for(:date_of_birth)
  should_not allow_value(1.1).for(:date_of_birth)

  should allow_value(100).for(:rating)
  should allow_value(0).for(:rating)
  should allow_value(nil).for(:rating)
  should_not allow_value(3009).for(:rating)
  should_not allow_value(-1).for(:rating)
  should_not allow_value(8.40).for(:rating)
  should_not allow_value("bad").for(:rating)

  context "Within context" do
    setup do 
     # create_family_users
      create_families
      create_students
      create_family_users
      create_inactive_students
      create_inactive_families
    end
    
   
    
     should "order students in alphabetical order" do
      assert_equal ["Ahmed, Rahil", "Kamath, Ashwini" , "Sadeka, Samiha"], Student.alphabetical.all.map(&:name)
    end
    
     should "have below_rating scope" do 
      assert_equal 2, Student.below_rating(1000).size
      assert_equal ["Rahil", "Samiha"], Student.below_rating(1000).all.map(&:first_name).sort  
      assert_equal 3, Student.below_rating(3000).size
      assert_equal ["Ashwini", "Rahil" , "Samiha"], Student.below_rating(3000).all.map(&:first_name).sort  
      
      
    end

    should "have at_or_above_rating scope" do
     
      assert_equal 1, Student.at_or_above_rating(2010).size
      assert_equal ["Ashwini"], Student.at_or_above_rating(1010).all.map(&:first_name).sort      
    end
    
    should "return active students" do
     
      assert_equal 2, Student.active.size
      assert_equal ["Ashwini", "Rahil"], Student.active.all.map(&:first_name).sort
     
    end
    
    should "return inactive students" do
     
      assert_equal 1, Student.inactive.size
      assert_equal ["Samiha"], Student.inactive.all.map(&:first_name).sort
    
    end
    
    should "show that name method works" do
      assert_equal "Kamath, Ashwini", @ashwini.name
     
    end
    
    should "show that proper_name method works" do
      assert_equal "Rahil Ahmed", @rahil.proper_name
     
    end
    
      should "check the student with no rating has default set to zero" do
      @hasan_user   = FactoryBot.create(:user, username: "hasann", role: "admin", active: false , password: "food" , phone: "124-789-0987" , password_confirmation: "food", email: "hasan@qatar.cmu.edu")
      @hasan = FactoryBot.create(:family, user: @hasan_user, family_name: "Hasan", parent_first_name: "Mohammad", active: false)
      @ha = FactoryBot.create(:student, family: @hasan, first_name: "Hasann", last_name: "Sun", date_of_birth: 25.years.ago.to_date, active: false, rating: nil)
    
     
      assert_equal 0, @ha.rating
     
    end
    
     should "have an  age method" do 
      assert_equal 18, @rahil.age 
      assert_equal 21, @ashwini.age  
    end
    
     should "not allow locations with past camps to be destroyed" do
      
      
      @GIS = FactoryBot.create(:curriculum, name: "Gis", min_rating: 800, max_rating: 3000, active: true)
      @medium = FactoryBot.create(:curriculum, name: "Medium", min_rating: 0, max_rating: 1000, active: true)
      @ec = FactoryBot.create(:location, name: 'Ec',  street_1: 'al-luqta' , max_capacity: 100, zip: 15213 , active: true) 
      @khor = FactoryBot.create(:location, name: 'Khor',  street_1: 'al-dar' , max_capacity: 150, zip: 15210 , active: true)
       
      @ec_camp = FactoryBot.create(:camp, curriculum: @GIS, start_date: Date.new(2018,10,9), end_date: Date.new(2018,10,25),  time_slot: "pm", location: @ec , active: true , cost: 150.0)
      @khor_camp = FactoryBot.create(:camp, curriculum: @medium, start_date: Date.new(2018,10,19), end_date: Date.new(2018,10,25), time_slot: "am", location: @khor , active: true , cost: 140.0)
        
      @ashwini_reg = FactoryBot.create(:registration, camp: @ec_camp, student: @ashwini)
      @rahil_reg = FactoryBot.create(:registration, camp: @khor_camp, student: @rahil)
     
       @ec_camp.update_attribute(:start_date, 52.weeks.ago.to_date)
      @ec_camp.update_attribute(:end_date, 51.weeks.ago.to_date)
      assert_not @ashwini.destroy      
     
    end
    
  end
end