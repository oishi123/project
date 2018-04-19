# require needed files
require './test/sets/curriculum_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_contexts'
require './test/sets/camp_instructor_contexts'
require './test/sets/location_contexts'
require './test/sets/student_contexts'
require './test/sets/family_contexts'
require './test/sets/user_contexts'
require './test/sets/registration_contexts'
require './test/sets/credit_card_contexts'


module Contexts
include Contexts::CurriculumContexts
  def create_contexts
    create_curriculums
    create_more_curriculums
    
  end
  
  
  
  include Contexts::LocationContexts
  def create_contexts
    create_locations
     create_active_locations
  end
  
   include Contexts::CampContexts
  def create_contexts
    create_camps
     create_past_camps
    create_upcoming_camps
  end
  
  include Contexts::InstructorContexts
  def create_contexts
    create_instructors
     create_more_instructors
    
  end
  
   include Contexts::CampInstructorContexts
  def create_contexts
   
    create_camp_instructors
    create_more_camp_instructors
    
  end
  
   include Contexts::CampContexts
  def create_contexts
    create_past_camps
    
  end
  
   include Contexts::StudentContexts
  def create_contexts
    create_students
    create_inactive_students
    
  end
  
   include Contexts::FamilyContexts
  def create_contexts
    create_families
    create_inactive_families
    
  end
  
    include Contexts::UserContexts
  def create_contexts
    create_users
    create_family_users
    
  end
  
   include Contexts::RegistrationContexts
  def create_contexts
    create_registrations
  
  end
  
  include Contexts::CreditCardContexts
  def create_contexts
    create_valid_cards
    create_invalid_card_lengths
    create_invalid_card_prefixes
    create_invalid_card_dates
end
end


