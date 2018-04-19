module Contexts
  module StudentContexts
      def create_students
          
          @rahil = FactoryBot.create(:student, family: @ahmed, rating: 0 , first_name: "Rahil" , last_name: "Ahmed" , date_of_birth: 18.years.ago.to_date)
          @ashwini = FactoryBot.create(:student, family: @kamath, rating: 2010 , first_name: "Ashwini" , last_name: "Kamath" , date_of_birth: 21.years.ago.to_date)
     
      end

    def delete_students
      @rahil.delete
      @ashwini.delete
     
    end

    def create_inactive_students
       @sadeka_user   = FactoryBot.create(:user, username: "sadekaa", role: "admin", active: false , password: "moguu" , phone: "124-789-0987" , password_confirmation: "moguu", email: "msa@qatar.cmu.edu")
        @sadeka = FactoryBot.create(:family, user: @sadeka_user, family_name: "Sadeka", parent_first_name: "Mohammad", active: false)
      @samiha = FactoryBot.create(:student, family: @sadeka, first_name: "Samiha", last_name: "Sadeka", date_of_birth: 22.years.ago.to_date, active: false, rating: nil)
    end

    def delete_inactive_students
      @samiha
    end
  end
end