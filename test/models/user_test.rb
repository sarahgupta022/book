require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end
  
   test "user should enter a last name" do
                user = User.new
                assert !user.save
                assert !user.errors[:last_name].empty?
        end
        
        test "user should enter a profile name" do
                user = User.new
                assert !user.save
                assert !user.errors[:profile_name].empty?
        end
          test "a user should have a unique profile name" do
                user = User.new
                user.profile_name = users(:sarah).profile_name
                assert !user.save
                assert !user.errors[:profile_name].empty?
        end
    
           test "a user should have profile name without spaces" do
            user = User.new(first_name: 'sarah', last_name: 'gupta', email: 'sarahgupta022@gmail.com')
            user.password = user.password_confirmation = 'welcome'
            user.profile_name = "My Profile With  Space"
            assert !user.save
            assert !user.errors[:profile_name].empty?
            assert user.errors[:profile_name].include?("Must be formatted correctly.")
    end

    test "a user can have a correctly formatted profile name" do
      user = User.new(first_name: 'sarah', last_name: 'gupta', email: 'sarahgupta022@gmail.com')
      user.password = user.password_confirmation = 'welcome'
      user.profile_name = 'sarahgupta'
      assert !user.valid?
        
 end

end
