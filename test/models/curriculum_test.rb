require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test relationships
  should have_many(:camps)

  # test validations
  should validate_presence_of(:name)
 # should validate_uniqueness_of(:name).case_insensitive

  should allow_value(1000).for(:min_rating)
  should allow_value(100).for(:min_rating)
  should allow_value(2872).for(:min_rating)
  should allow_value(0).for(:min_rating)

  should_not allow_value(nil).for(:min_rating)
  should_not allow_value(3001).for(:min_rating)
  should_not allow_value(50).for(:min_rating)
  should_not allow_value(-1).for(:min_rating)
  should_not allow_value(500.50).for(:min_rating)
  should_not allow_value("bad").for(:min_rating)

  should allow_value(1000).for(:max_rating)
  should allow_value(100).for(:max_rating)
  should allow_value(2872).for(:max_rating)

  should_not allow_value(nil).for(:max_rating)
  should_not allow_value(3001).for(:max_rating)
  should_not allow_value(50).for(:max_rating)
  should_not allow_value(-1).for(:max_rating)
  should_not allow_value(500.50).for(:max_rating)
  should_not allow_value("bad").for(:max_rating)

    # test that max greater than min rating
  should "shows that max rating is greater than min rating" do
    bad = FactoryBot.build(:curriculum, name: "Bad curriculum", min_rating: 500, max_rating: 500)
    very_bad = FactoryBot.build(:curriculum, name: "Very bad curriculum", min_rating: 500, max_rating: 450)
    deny bad.valid?
    deny very_bad.valid?
  end

  context "Within context" do
    # create the objects I want with factories
    setup do 
      create_curriculums
    end
    
    # and provide a teardown method as well
   

    # test the scope 'alphabetical'
    should "shows that there are three curriculums in in alphabetical order" do
      assert_equal ["Endgame Principles", "Mastering Chess Tactics", "Smith-Morra Gambit"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
    end
    
    # test the scope 'active'
    should "shows that there are two active curriculums" do
      assert_equal 2, Curriculum.active.size
      assert_equal ["Endgame Principles", "Mastering Chess Tactics"], Curriculum.active.all.map(&:name).sort, "#{Curriculum.methods}"
    end
    
    # test the scope 'active'
    should "shows that there is one inactive curriculum" do
      assert_equal 1, Curriculum.inactive.size
      assert_equal ["Smith-Morra Gambit"], Curriculum.inactive.all.map(&:name).sort
    end

    # test the scope 'for_rating'
    should "shows that there is a working for_rating scope" do
      assert_equal 1, Curriculum.for_rating(1400).size
      assert_equal ["Mastering Chess Tactics","Smith-Morra Gambit"], Curriculum.for_rating(600).all.map(&:name).sort
    end
    
    should "show that curriculums cannot be destroyed" do
      assert_not @tactics.destroy
    end
    
  #   should "show that curriculum is not active for an upcoming camp" do
      
  #     @curriculum = FactoryBot.create(:curriculum,  name: "CS", min_rating: 700, max_rating: 3000, active: true)
  #     @cmu = FactoryBot.create(:location) 
  #     @fareej =  FactoryBot.create(:camp,  curriculum: @curriculum, start_date: Date.new(2018,10,3), end_date: Date.new(2018,10,7), time_slot: "am", location: @cmu, active: true)
  #     @kamath_user = FactoryBot.create(:user, username: "win", role: "parent", phone: "123-867-8904", email: "akammmath@qatar.cmu.edu" , password: "hates" , password_confirmation: "hates")
  #     @kamath = FactoryBot.create(:family, user: @kamath_user, family_name: "Kamath" , active: true)
  #     @ashwini = FactoryBot.create(:student, family: @kamath, rating: 2010 , first_name: "Ashwini" , last_name: "Kamath" , date_of_birth: 21.years.ago.to_date)
  #     @ashwini_reg = FactoryBot.create(:registration, camp: @fareej , student: @ashwini)
  #     @curriculum.update_attribute(:active , false)
  #     assert_equal true, @curriculum.active
  # end
  
  

  end
end
