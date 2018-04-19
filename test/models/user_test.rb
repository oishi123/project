require 'test_helper'

class UserTest < ActiveSupport::TestCase
 should have_secure_password

  
  should validate_presence_of(:username)

  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value(10).for(:role)
  
  should allow_value("sakhter@yahoo.com").for(:email)
  should allow_value("sakhter@andrew.cmu.edu").for(:email)
  should_not allow_value("sufia").for(:email)
  should_not allow_value(nil).for(:email)
  
  should allow_value("1234567890").for(:phone)
  should allow_value("(012) 268-3259").for(:phone)
  should_not allow_value(nil).for(:phone)
  
  
  # context
  context "Within context" do
    setup do
      create_users
    end
    
    # teardown do
    #   delete_users
    # end

    should "return unique username and verify" do
      assert_equal "winniesss", @kam_user.username
      @kam_user.username = "KAMATH"
      assert @kam_user.valid?, "#{@kam_user.username}"
    end

    should "allow user to authenticate with password" do
      assert @kam_user.authenticate("water")
      assert_not @kam_user.authenticate("red")
    end

    should "require a password for new users" do
      example = FactoryBot.build(:user, username: "love", password: nil)
     assert_not example.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      example_1 = FactoryBot.build(:user, username: "love", password: "pink", password_confirmation: "red")
      assert_not example_1.valid?
      example_2 = FactoryBot.build(:user, username: "done", password: "IS", password_confirmation: nil)
      assert_not example_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      example = FactoryBot.build(:user, username: "love", password: "L")
      assert_not example.valid?
    end

    should "verify the  phone number" do
      assert_equal "1235678903", @kam_user.phone
    end
end
end