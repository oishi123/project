FactoryBot.define do
 
  # factory :instructor do
  #   first_name "MyString"
  #   last_name "MyString"
  #   bio "MyText"
  #   email "MyString"
  #   phone "MyString"
  #   active false
   
  # end
  factory :user do
    username "tank"
   
    role "instructor"
   
  end
  factory :student do
    first_name "Ashwini"
    last_name "Kamath"
   
    rating 2010
    active true
  end
  factory :registration do
    association :camp
    association :student
  end
  factory :family do
    family_name "Ahmed"
    parent_first_name "Aahil"
   
  end
  
  factory :curriculum do
    name "Mastering Chess Tactics"
    description "This camp is designed for any student who has mastered basic mating patterns and understands opening principles and is looking to improve his/her ability use chess tactics in game situations."
    min_rating 400
    max_rating 850
    active true
  end
  
  factory :instructor do
    first_name "Mark"
    last_name "Heimann"
    bio "Mark is currently among the top 150 players in the United States and has won 4 national scholastic chess championships."
    
    active true
  end
  
  factory :camp do 
    cost 150
    start_date Date.new(2018,7,16)
    end_date Date.new(2018,7,20)
    time_slot "am"
    max_students 8
    active true
    association :curriculum
    association :location
  end
  
  factory :camp_instructor do 
     association :camp
     association :instructor
   end

  factory :location do
    name "Ec"
    street_1 "al-luqta"
    zip "15213"
    max_capacity 100
    active true
  end

end