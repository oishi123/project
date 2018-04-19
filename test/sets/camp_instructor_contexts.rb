module Contexts
  module CampInstructorContexts
    def create_camp_instructors
      # assumes create_curriculums, create_instructors, create_camps run prior
      
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Mark", bio: nil, active: true , user: @alex_user)
      @rachel = FactoryBot.create(:instructor, first_name: "Rachel", last_name: "Taylor", bio: nil, active: false , user: @rachel_user)
    
      @alex_c1 = FactoryBot.create(:camp_instructor, instructor: @alex, camp: @camp1)
      @alex_c2 = FactoryBot.create(:camp_instructor, instructor: @alex, camp: @camp2)
    end

    def delete_camp_instructors
     
    end

   
  end
end