module Contexts
  module FamilyContexts
  
    def create_families
     @kamath_user = FactoryBot.create(:user, username: "winnie", role: "parent", phone: "123-567-8904", email: "akamath@qatar.cmu.edu" , password: "loveeee", password_confirmation: "loveeee")
     @ahmed_user   = FactoryBot.create(:user, username: "jaahil", role: "parent" ,phone: "127-567-8904", email: "rahil@qatar.cmu.edu" , password: "awesome" ,password_confirmation: "awesome" )
     @sadek_user   = FactoryBot.create(:user, username: "sadeque", role: "admin" ,phone: "128-567-8904", email: "msadeka@qatar.cmu.edu" , password: "mogu" , password_confirmation: "mogu" )
      
      @kamath = FactoryBot.create(:family, user: @kamath_user, family_name: "Kamath" , active: true)
      @ahmed  = FactoryBot.create(:family, user: @ahmed_user, family_name: "Ahmed", parent_first_name: "Aahil", active: true)
      @sadek = FactoryBot.create(:family, user: @sadek_user, family_name: "Sadek", parent_first_name: "Mohammad", active: true)
    
    end

    def delete_families
      @kamath.delete
      @ahmed.delete
      @sadek.delete
      
    
    end

    def create_inactive_families
       @sadeka_user   = FactoryBot.create(:user, username: "sadeka", role: "admin", active: false , password: "moguu" , phone: "124-789-0987" , password_confirmation: "moguu", email: "msa@qatar.cmu.edu")
      @sadeka = FactoryBot.create(:family, user: @sadeka_user, family_name: "Sadeka", parent_first_name: "Mohammad", active: false)
    end

    def delete_inactive_families
      @sadeka.delete
    end
  end
end