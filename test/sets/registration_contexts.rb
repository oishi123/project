module Contexts
  module RegistrationContexts

    def create_registrations
      
      @GIS = FactoryBot.create(:curriculum, name: "Gis", min_rating: 800, max_rating: 3000, active: true)
      @medium = FactoryBot.create(:curriculum, name: "Medium", min_rating: 0, max_rating: 1000, active: true)
      @ec = FactoryBot.create(:location, name: 'Ec',  street_1: 'al-luqta' , max_capacity: 100, zip: 15213 , active: true) 
      @khor = FactoryBot.create(:location, name: 'Khor',  street_1: 'al-dar' , max_capacity: 150, zip: 15210 , active: true)
       
      @ec_camp = FactoryBot.create(:camp, curriculum: @GIS, start_date: Date.new(2018,10,9), end_date: Date.new(2018,10,25),  time_slot: "pm", location: @ec , active: true , cost: 150.0)
      @khor_camp = FactoryBot.create(:camp, curriculum: @medium, start_date: Date.new(2018,10,19), end_date: Date.new(2018,10,25), time_slot: "am", location: @khor , active: true , cost: 140.0)
        
      @ashwini_reg = FactoryBot.create(:registration, camp: @ec_camp, student: @ashwini)
      @rahil_reg = FactoryBot.create(:registration, camp: @khor_camp, student: @rahil)
     
    end

    def delete_registrations
      @ashwini_reg.delete
      @rahil_reg.delete
     
    end
  end
end