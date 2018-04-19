require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  should belong_to(:user)
 should have_many(:camp_instructors)
  should have_many(:camps).through(:camp_instructors)

  # test validations
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)


  # set up context
  context "Within context" do
    setup do 
      create_users
      create_instructors
    end
    
    teardown do
      #delete_instructors
      #delete_users
    end

    should "show that there are three instructors in alphabetical order" do
      
      assert_equal ["Alex",  "Rachel"], Instructor.alphabetical.all.map(&:first_name)
    end

    should "show that there are active instructors" do
      assert_equal 1, Instructor.active.size
      assert_equal ["Alex"], Instructor.active.all.map(&:first_name).sort
    end
    
    should "show that there is one inactive instructor" do
      assert_equal 1, Instructor.inactive.size
      assert_equal ["Rachel"], Instructor.inactive.all.map(&:first_name).sort
    end

    should "show that there are two instructors needing bios" do
      
      assert_equal 2, Instructor.needs_bio.size
      assert_equal ["Alex", "Rachel"], Instructor.needs_bio.all.map(&:first_name).sort
    end

    should "show that name method works" do
     
      assert_equal "Mark, Alex", @alex.name
    end
    
    should "show that proper_name method works" do
     
      assert_equal "Alex Mark", @alex.proper_name
    end

    should "have a class method to give array of instructors for a given camp" do
      # create additional contexts that are needed
      create_curriculums
      create_active_locations
      create_camps
      
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Mark", bio: nil, active: true , user: @alex_user)
      @alex_c1 = FactoryBot.create(:camp_instructor, instructor: @alex, camp: @camp1)
      assert_equal ["Alex"], Instructor.for_camp(@camp1).map(&:first_name).sort
     
     
    end

    
    should "deactivate a user if the instructor becomes inactive" do
      @alex.active = false
      @alex.save
      assert_not @alex.user.active
    end
    
    should "allow an instructor to be destroyed if not taught a past camp" do
      
      assert @alex.camps.past.empty?
      assert @alex.destroy
    end

    should "not allow an instructor to be destroyed if has taught a past camp" do
      @GIS = FactoryBot.create(:curriculum, name: "Gis", min_rating: 800, max_rating: 3000, active: true)
      @medium = FactoryBot.create(:curriculum, name: "Medium", min_rating: 0, max_rating: 1000, active: true)
      @ec = FactoryBot.create(:location, name: 'Ec',  street_1: 'al-luqta' , max_capacity: 100, zip: 15213 , active: true) 
      @khor = FactoryBot.create(:location, name: 'Khor',  street_1: 'al-dar' , max_capacity: 150, zip: 15210 , active: true)
       
      @ec_camp = FactoryBot.create(:camp, curriculum: @GIS, start_date: Date.new(2018,10,9), end_date: Date.new(2018,10,25),  time_slot: "pm", location: @ec , active: true , cost: 150.0)
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Mark", bio: nil, active: true , user: @alex_user)
      @alex_c1 = FactoryBot.create(:camp_instructor, instructor: @alex, camp: @ec_camp)
      @ec_camp.update_attribute(:start_date, 52.weeks.ago.to_date)
      @ec_camp.update_attribute(:end_date, 51.weeks.ago.to_date)
      assert_not @alex.destroy      
     
    
    end
 
    
   
   
end
end
