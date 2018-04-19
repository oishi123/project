require 'test_helper'

class CampInstructorTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:camp)
  should belong_to(:instructor)

  # test validations
  should validate_presence_of(:camp_id)
  should validate_presence_of(:instructor_id)
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:instructor_id).only_integer.is_greater_than(0)

  # set up context
  include Contexts
  context "Within context" do
    setup do 
      create_curriculums
      create_users
       create_instructors
      create_active_locations
     
      create_camps
      create_camp_instructors
      
    end
    
    teardown do
    
    end

    should "not allow the same instructor to assigned twice to the same camp" do
     
      bad_assignment = FactoryBot.build(:camp_instructor, instructor: @alex, camp: @camp1)
      deny bad_assignment.valid?
    end

    should "not allow the same instructor to assigned to another camp at the same time" do
      camp5 = FactoryBot.create(:camp, curriculum: @tactics, location: @north)    
      bad_assignment = FactoryBot.build(:camp_instructor, instructor: @alex, camp: @camp5)
      deny bad_assignment.valid?
     
    end

    should "not allow an instructor to assigned an inactive camp" do
      bad_assignment = FactoryBot.build(:camp_instructor, instructor: @alex, camp: @camp100)
      deny bad_assignment.valid?
    end

    should "not allow an inactive instructor to assigned to a camp" do
      bad_assignment = FactoryBot.build(:camp_instructor, instructor: @rachel, camp: @camp4)
      deny bad_assignment.valid?
    end
  end
end
