require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.error[:first_name].empty?
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
                user.profile_name = users(:test).profile_name
                assert !user.save
                assert !user.errors[:profile_name].empty?
        end
test "a user should have a unique profile name" do
                user = User.new
                user.profile_name = user(:premlata).profile_name
                assert !user.save
                assert !user.errors[:profile_name].empty?
        end
            test "a user should have profile name without spaces" do
                user = User.new
                user.password = user.password_confirmation = 'dwaddwad'
                user.profile_name = "My Profile With  Space"
                assert !user.save
                assert !user.errors[:profile_name].empty?
                assert user.errors[:profile_name].include?("Must be formatted correctly.")
        end
end


