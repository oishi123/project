module Contexts
  module InstructorContexts
    def create_instructors
      
      @alex   = FactoryBot.create(:instructor, first_name: "Alex", last_name: "Mark", bio: nil, active: true , user: @alex_user)

      @rachel = FactoryBot.create(:instructor, first_name: "Rachel", last_name: "Taylor", bio: nil, active: false , user: @rachel_user)
    end

   
   
  end
end