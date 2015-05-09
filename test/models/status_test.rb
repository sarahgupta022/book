require 'test_helper'

class StatusTest < ActiveSupport::TestCase
test"that a status requires context"do
  status=Status.new
  assert !status.save
  assert !status.error[:context].empty?
  end
test"that a status's context is at least 2 letters"do
  status=Status.new
  ststus.context="H"
  assert !status.save
  assert !status.error[:context].empty?
  end
test"that a status has a user id"do
  status=Status.new
  status.context="Hello"
  assert !status.save
  assert !status.error[:user_id].empty?
  end
   
end
