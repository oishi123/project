module Contexts
  module UserContexts
    def create_users
      @kam_user = FactoryBot.create(:user , username: "winniesss" , role: "instructor" , phone: "123-567-8903", email: "akam@qatar.cmu.edu" , password: "water" , password_confirmation: "water" )
      @ahm_user = FactoryBot.create(:user, username: "robber", phone: "123-456-7890" , role: "parent",  phone: "123-567-9904", email: "ahm@qatar.cmu.edu" , password: "drift" , password_confirmation: "drift")
      @alex_user = FactoryBot.create(:user, username: "tannk", phone: "412-369-4314",email: "ahmn@qatar.cmu.edu" , password: "dnrift" , password_confirmation: "dnrift", role: "instructor" )
      @rachel_user = FactoryBot.create(:user, username: "racheel", role: "instructor" ,email: "ahjm@qatar.cmu.edu" , password: "drrift" , password_confirmation: "drrift", phone: "678-098-7890")
    end

    def delete_users
      @kam_user.delete
      @ahm_user.delete
      @alex_user.delete
      @rachel_user.delete
   
    end

   
    def create_family_users
      @kamathi_user = FactoryBot.create(:user, username: "winniess", role: "parent", phone: "123-567-8904", email: "akammath@qatar.cmu.edu" , password: "hate" , password_confirmation: "hate")
      @ahmedi_user   = FactoryBot.create(:user, username: "jaahils", role: "parent" ,phone: "120-567-8904", email: "rahill@qatar.cmu.edu" , password: "love" , password_confirmation: "love")
    
    end

    def delete_family_users
      @kamathi_user.delete
      @ahmedi_user.delete
     
    end
  end
end